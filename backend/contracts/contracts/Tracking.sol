// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract ProductTracker is ERC721, AccessControl {
    struct Product {
        string name;
        string details;
        uint256 creationDate;
        string manufacturer;
        string distributor;
        string retailer;
        ProductStatus status;
    }

    enum ProductStatus { Manufactured, Distributed, Retail, Sold }

    mapping(uint256 => Product) public products;

    bytes32 public constant MANUFACTURER_ROLE = keccak256("MANUFACTURER_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");
    bytes32 public constant RETAILER_ROLE = keccak256("RETAILER_ROLE");
    bytes32 public constant ADMIN_ROLE = DEFAULT_ADMIN_ROLE;

    event ProductCreated(uint256 indexed productId, string name, string manufacturer);
    event ProductDetailsUpdated(uint256 indexed productId, string details);
    event ProductStatusChanged(uint256 indexed productId, ProductStatus status);
    event ProductOwnershipTransferred(uint256 indexed productId, address indexed from, address indexed to);

    constructor() ERC721("ProductTracker", "PTK") {
        _setupRole(ADMIN_ROLE, msg.sender);
    }

    function createProduct(uint256 productId, string memory name, string memory details, string memory manufacturer) public onlyRole(MANUFACTURER_ROLE) {
        require(products[productId].creationDate == 0, "Product already exists");
        products[productId] = Product(name, details, block.timestamp, manufacturer, "", "", ProductStatus.Manufactured);
        _mint(msg.sender, productId);
        emit ProductCreated(productId, name, manufacturer);
    }

    function updateProductDetails(uint256 productId, string memory newDetails) public {
        require(_exists(productId), "Product does not exist");
        require(hasRole(MANUFACTURER_ROLE, msg.sender) || hasRole(DISTRIBUTOR_ROLE, msg.sender), "Not authorized");
        products[productId].details = newDetails;
        emit ProductDetailsUpdated(productId, newDetails);
    }

    function changeProductStatus(uint256 productId, ProductStatus newStatus) public {
        require(_exists(productId), "Product does not exist");
        require(hasRole(MANUFACTURER_ROLE, msg.sender) || hasRole(DISTRIBUTOR_ROLE, msg.sender) || hasRole(RETAILER_ROLE, msg.sender), "Not authorized");
        products[productId].status = newStatus;
        emit ProductStatusChanged(productId, newStatus);
    }

    function transferProduct(uint256 productId, address newOwner) public {
        require(ownerOf(productId) == msg.sender, "Only the owner can transfer the product");
        require(hasRole(DISTRIBUTOR_ROLE, msg.sender) || hasRole(RETAILER_ROLE, msg.sender), "Not authorized to transfer");
        _transfer(msg.sender, newOwner, productId);
        emit ProductOwnershipTransferred(productId, msg.sender, newOwner);
    }

    function addRole(bytes32 role, address account) public onlyRole(ADMIN_ROLE) {
        _setupRole(role, account);
    }

    function removeRole(bytes32 role, address account) public onlyRole(ADMIN_ROLE) {
        revokeRole(role, account);
    }

    // Override function supportsInterface
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}