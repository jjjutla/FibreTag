const { ethers, upgrades } = require('hardhat');
const { expect } = require('chai');
const { BigNumber } = ethers;
const Web3EthAbi = require('web3-eth-abi');
const ERC1967Proxy = require('@openzeppelin/contracts/build/contracts/ERC1967Proxy.json');

const contracts = {};
const users = {};

beforeEach(async function () {
  [users.owner, users.backend, users.user1, users.addr2] = await ethers.getSigners();

  contracts.NFT = await getContractWithProxy('NFT');
  await contracts.NFT.grantRole(await contracts.NFT.MINTER_ROLE(), users.backend.address);
});

async function getContractWithProxy(contractName) {
  const Contract = await ethers.getContractFactory(contractName);
  const contract = await Contract.deploy();

  const Proxy = await ethers.getContractFactoryFromArtifact(ERC1967Proxy);
  const callInitialize = Web3EthAbi.encodeFunctionCall(
    Contract.interface.fragments.find(({ name }) => name === 'initialize'),
    []
  );

  const proxy = await Proxy.deploy(contract.address, callInitialize);

  const proxiedContract = Contract.attach(proxy.address);
  return proxiedContract;
}

describe('NFT', function () {

  describe('Initialization', function () {
    it('should initialize the contract correctly', async function () {
      expect(await contracts.NFT.name()).to.equal('NFT');
      expect(await contracts.NFT.symbol()).to.equal('NFT');
      expect(await contracts.NFT.hasRole(await contracts.NFT.DEFAULT_ADMIN_ROLE(), users.owner.address)).to.be.true;
      expect(await contracts.NFT.hasRole(await contracts.NFT.MINTER_ROLE(), users.owner.address)).to.be.true;
      expect(await contracts.NFT.hasRole(await contracts.NFT.UPGRADER_ROLE(), users.owner.address)).to.be.true;
    });
  });

  describe('safeMint(address, tokenId)', () => {
    it('allows to mint tokens by Backend', async () => {
      const tokenId = +new Date();
      const transaction = await contracts.NFT.connect(users.backend).safeMint(users.user1.address, tokenId);
      const { events } = await transaction.wait();

      const event = events.find(({ event }) => event === 'Transfer').args;
      expect(event.tokenId).toEqual(BigNumber.from(tokenId));
    });

    it('rejects minting by generic users', async () => {
      const tokenId = +new Date();
      await expect(contracts.NFT.connect(users.user1).safeMint(users.user1.address, tokenId)).to.be.revertedWith('AccessControl');
    });
  });

  describe('burn(tokenId)', () => {
    it('allows to burn tokens by Backend', async () => {
      const tokenId = +new Date();
      await contracts.NFT.connect(users.backend).safeMint(users.user1.address, tokenId);
      await contracts.NFT.connect(users.backend).burn(tokenId);

      await expect(contracts.NFT.ownerOf(tokenId)).to.be.revertedWith('ERC721: invalid token ID');
    });

    it('rejects burning by generic users', async () => {
      const tokenId = +new Date();
      await expect(contracts.NFT.connect(users.user1).burn(tokenId)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Minting', function () {
    it('should allow minters to mint tokens', async function () {
      const tokenId = +new Date();
      await contracts.NFT.safeMint(users.user1.address, tokenId);
      expect(await contracts.NFT.ownerOf(tokenId)).to.equal(users.user1.address);
    });

    it('should not allow non-minters to mint tokens', async function () {
      const tokenId = +new Date();
      await expect(contracts.NFT.connect(users.user1).safeMint(users.user1.address, tokenId)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Burning', function () {
    it('should allow minters to burn tokens', async function () {
      const tokenId = +new Date();
      await contracts.NFT.safeMint(users.user1.address, tokenId);
      await contracts.NFT.burn(tokenId);
      await expect(contracts.NFT.ownerOf(tokenId)).to.be.revertedWith('ERC721: invalid token ID');
    });

    it('should not allow non-minters to burn tokens', async function () {
      const tokenId = +new Date();
      await contracts.NFT.safeMint(users.user1.address, tokenId);
      await expect(contracts.NFT.connect(users.user1).burn(tokenId)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Upgradeability', function () {
    it('should upgrade the contract', async function () {
      const NFTv2 = await ethers.getContractFactory('NFTv2');
      const nftv2 = await upgrades.upgradeProxy(contracts.NFT.address, NFTv2);
      expect(await nftv2.version()).to.equal('v2');
    });
  });

  describe('Access Control', function () {
    it('should allow the admin to grant roles', async function () {
      await contracts.NFT.grantRole(await contracts.NFT.MINTER_ROLE(), users.user1.address);
      expect(await contracts.NFT.hasRole(await contracts.NFT.MINTER_ROLE(), users.user1.address)).to.be.true;
    });

    it('should not allow non-admins to grant roles', async function () {
      await expect(contracts.NFT.connect(users.user1).grantRole(await contracts.NFT.MINTER_ROLE(), users.addr2.address)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Enumerable', function () {
    it('should enumerate tokens correctly', async function () {
      const tokenId1 = +new Date();
      const tokenId2 = tokenId1 + 1;
      await contracts.NFT.safeMint(users.user1.address, tokenId1);
      await contracts.NFT.safeMint(users.user1.address, tokenId2);
      expect(await contracts.NFT.totalSupply()).to.equal(2);
      expect(await contracts.NFT.tokenOfOwnerByIndex(users.user1.address, 0)).to.equal(tokenId1);
      expect(await contracts.NFT.tokenOfOwnerByIndex(users.user1.address, 1)).to.equal(tokenId2);
    });
  });

  describe('Supports Interface', function () {
    it('should support required interfaces', async function () {
      expect(await contracts.NFT.supportsInterface('0x80ac58cd')).to.be.true; // ERC721
      expect(await contracts.NFT.supportsInterface('0x5b5e139f')).to.be.true; // ERC721metadata
      expect(await contracts.NFT.supportsInterface('0x780e9d63')).to.be.true; // ERC721enumerable
      expect(await contracts.NFT.supportsInterface('0x7965db0b')).to.be.true; // accesscontrol
    });
  });

});
