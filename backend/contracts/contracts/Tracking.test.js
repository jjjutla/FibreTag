const { expect } = require('chai');
const { ethers } = require('hardhat');

describe('ProductTracker', function () {
  let ProductTracker, productTracker, owner, manufacturer, distributor, retailer, user;

  beforeEach(async function () {
    [owner, manufacturer, distributor, retailer, user] = await ethers.getSigners();

    const ProductTrackerFactory = await ethers.getContractFactory('ProductTracker');
    productTracker = await ProductTrackerFactory.deploy();
    await productTracker.deployed();

    await productTracker.addRole(await productTracker.MANUFACTURER_ROLE(), manufacturer.address);
    await productTracker.addRole(await productTracker.DISTRIBUTOR_ROLE(), distributor.address);
    await productTracker.addRole(await productTracker.RETAILER_ROLE(), retailer.address);
  });

  describe('Initialization', function () {
    it('should initialize the contract correctly', async function () {
      expect(await productTracker.name()).to.equal('ProductTracker');
      expect(await productTracker.symbol()).to.equal('PTK');
      expect(await productTracker.hasRole(await productTracker.ADMIN_ROLE(), owner.address)).to.be.true;
    });
  });

  describe('Role-Based Access Control', function () {
    it('should allow admin to add and remove roles', async function () {
      await productTracker.addRole(await productTracker.MANUFACTURER_ROLE(), user.address);
      expect(await productTracker.hasRole(await productTracker.MANUFACTURER_ROLE(), user.address)).to.be.true;

      await productTracker.removeRole(await productTracker.MANUFACTURER_ROLE(), user.address);
      expect(await productTracker.hasRole(await productTracker.MANUFACTURER_ROLE(), user.address)).to.be.false;
    });

    it('should not allow non-admin to add or remove roles', async function () {
      await expect(productTracker.connect(user).addRole(await productTracker.MANUFACTURER_ROLE(), user.address)).to.be.revertedWith('AccessControl');
      await expect(productTracker.connect(user).removeRole(await productTracker.MANUFACTURER_ROLE(), manufacturer.address)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Product Creation', function () {
    it('should allow manufacturers to create products', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      const tx = await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);
      const receipt = await tx.wait();

      const event = receipt.events.find(event => event.event === 'ProductCreated');
      expect(event.args.productId).to.equal(productId);
      expect(event.args.name).to.equal(name);
      expect(event.args.manufacturer).to.equal(manufacturerName);
    });

    it('should not allow non-manufacturers to create products', async function () {
      const productId = 2;
      const name = 'Product2';
      const details = 'Details of Product2';
      const manufacturerName = 'Manufacturer2';

      await expect(productTracker.connect(user).createProduct(productId, name, details, manufacturerName)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Product Details Update', function () {
    it('should allow manufacturers and distributors to update product details', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      const newDetails = 'Updated details of Product1';
      const tx = await productTracker.connect(distributor).updateProductDetails(productId, newDetails);
      const receipt = await tx.wait();

      const event = receipt.events.find(event => event.event === 'ProductDetailsUpdated');
      expect(event.args.productId).to.equal(productId);
      expect(event.args.details).to.equal(newDetails);
    });

    it('should not allow unauthorized roles to update product details', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      const newDetails = 'Updated details of Product1';
      await expect(productTracker.connect(user).updateProductDetails(productId, newDetails)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Product Status Change', function () {
    it('should allow authorized roles to change product status', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      const newStatus = 1; // Distributed
      const tx = await productTracker.connect(distributor).changeProductStatus(productId, newStatus);
      const receipt = await tx.wait();

      const event = receipt.events.find(event => event.event === 'ProductStatusChanged');
      expect(event.args.productId).to.equal(productId);
      expect(event.args.status).to.equal(newStatus);
    });

    it('should not allow unauthorized roles to change product status', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      const newStatus = 1; // Distributed
      await expect(productTracker.connect(user).changeProductStatus(productId, newStatus)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Product Transfer', function () {
    it('should allow the owner to transfer product ownership', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      const tx = await productTracker.connect(manufacturer).transferProduct(productId, retailer.address);
      const receipt = await tx.wait();

      const event = receipt.events.find(event => event.event === 'ProductOwnershipTransferred');
      expect(event.args.productId).to.equal(productId);
      expect(event.args.from).to.equal(manufacturer.address);
      expect(event.args.to).to.equal(retailer.address);
      expect(await productTracker.ownerOf(productId)).to.equal(retailer.address);
    });

    it('should not allow unauthorized users to transfer product ownership', async function () {
      const productId = 1;
      const name = 'Product1';
      const details = 'Details of Product1';
      const manufacturerName = 'Manufacturer1';

      await productTracker.connect(manufacturer).createProduct(productId, name, details, manufacturerName);

      await expect(productTracker.connect(user).transferProduct(productId, retailer.address)).to.be.revertedWith('AccessControl');
    });
  });

  describe('Supports Interface', function () {
    it('should support required interfaces', async function () {
      expect(await productTracker.supportsInterface('0x80ac58cd')).to.be.true; // ERC721
      expect(await productTracker.supportsInterface('0x5b5e139f')).to.be.true; // ERC721metadata
      expect(await productTracker.supportsInterface('0x7965db0b')).to.be.true; // accesscontrol
    });
  });

});
