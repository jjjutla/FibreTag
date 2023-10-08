const { ethers } = require('hardhat')
const { BigNumber } = ethers
const Web3EthAbi = require('web3-eth-abi')
const ERC1967Proxy = require('@openzeppelin/contracts/build/contracts/ERC1967Proxy.json')

const contracts = {}
const users = {}
beforeEach(async function () {
  [users.owner, users.backend, users.user1] = await ethers.getSigners()

  contracts.NFT = await getContractWithProxy('NFT')
  await contracts.NFT.grantRole(await contracts.NFT.MINTER_ROLE(), users.backend.address)
})

describe('safeMint(address, tokenId)', () => {
  it('allows to mint tokens by Backend', async () => {
    const tokenId = +new Date()
    const transaction = await contracts.NFT.connect(users.backend).safeMint(users.user1.address, tokenId)
    const { events } = await transaction.wait()

    const event = events.find(({ event }) => event === 'Transfer').args
    expect(event.tokenId).toEqual(BigNumber.from(tokenId))
  })

  it('rejects minting by generic users', async () => {
    const tokenId = +new Date()
    await expect(contracts.NFT.connect(users.user1).safeMint(users.user1.address, tokenId)).rejects.toThrow('is missing role')
  })
})

describe('burn(tokenId)', () => {
  it('allows to burn tokens by Backend', async () => {
    const tokenId = +new Date()
    await contracts.NFT.connect(users.backend).safeMint(users.user1.address, tokenId)
    await contracts.NFT.connect(users.backend).burn(tokenId)

    await expect(contracts.NFT.ownerOf(tokenId)).rejects.toThrow('ERC721: invalid token ID')
  })

  it('rejects burning by generic users', async () => {
    const tokenId = +new Date()
    await expect(contracts.NFT.connect(users.user1).burn(tokenId)).rejects.toThrow('is missing role')
  })
})

async function getContractWithProxy (contractName) {
  // get contract details
  const Contract = await ethers.getContractFactory(contractName)
  const contract = await Contract.deploy()

  const Proxy = await ethers.getContractFactoryFromArtifact(ERC1967Proxy)

  // calculate initialize() call during deployment
  const callInitialize = Web3EthAbi.encodeFunctionCall(
    Contract.interface.fragments.find(({ name }) => name === 'initialize'), []
  )

  // deploy proxy pointing to contract
  const proxy = await Proxy.deploy(contract.address, callInitialize)

  // return proxy address attached with contract functionality
  const proxiedContract = Contract.attach(proxy.address)
  return proxiedContract
}
