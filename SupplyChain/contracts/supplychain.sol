// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract supplychain {

    enum StageStatus {
        NOT_STARTED,
        STARTED,
        COMPLETED
    }

    struct ManufacturingStage {
        string name;
        StageStatus status;
        string startTimestamp;
        string endTimestamp;
    }

    struct Product {
        string description;
        address owner;
        ManufacturingStage[] stages;
        string[] history;
        string[] timestamps;
    }

    mapping(uint256 => Product) public products; // productID => Product
    uint256 public productCount = 0;

    function createProduct(string memory _description, string memory _timestamp) public returns (uint256) {
        productCount++;
        products[productCount].description = _description;
        products[productCount].owner = address(this);
        products[productCount].history.push("Product created");
        products[productCount].timestamps.push(_timestamp);
        return productCount;
    }

    function addManufacturingStage(uint256 _productId, string memory stageName,string memory _timestamp) public {
        ManufacturingStage memory newStage = ManufacturingStage({
            name: stageName,
            status: StageStatus.NOT_STARTED,
            startTimestamp: "",
            endTimestamp: ""
        });
        products[_productId].stages.push(newStage);
        products[_productId].history.push(string(abi.encodePacked("Stage added: ", stageName)));
        products[_productId].timestamps.push(_timestamp);
    }

    function startManufacturingStage(uint256 _productId, uint256 stageIndex, string memory _timestamp) public {
        require(products[_productId].stages[stageIndex].status == StageStatus.NOT_STARTED, "Stage has either started or completed");
        products[_productId].stages[stageIndex].status = StageStatus.STARTED;
        products[_productId].stages[stageIndex].startTimestamp = _timestamp;
        products[_productId].history.push(string(abi.encodePacked("Manufacturing stage started: ", products[_productId].stages[stageIndex].name)));
        products[_productId].timestamps.push(_timestamp);
    }

    function completeManufacturingStage(uint256 _productId, uint256 stageIndex, string memory _timestamp) public {
        require(products[_productId].stages[stageIndex].status == StageStatus.STARTED, "Stage has not started or already completed");
        products[_productId].stages[stageIndex].status = StageStatus.COMPLETED;
        products[_productId].stages[stageIndex].endTimestamp = _timestamp;
        products[_productId].history.push(string(abi.encodePacked("Manufacturing stage completed: ", products[_productId].stages[stageIndex].name)));
        products[_productId].timestamps.push(_timestamp);
    }

    function sellProduct(uint256 _productId, address _newOwner, string memory _timestamp) public {
        require(products[_productId].owner == address(this), "Product is already sold or not available");
        products[_productId].owner = _newOwner;
        products[_productId].history.push("Product sold");
        products[_productId].timestamps.push(_timestamp);
    }

    function getHistory(uint256 _productId) public view returns (string[] memory, string[] memory) {
        return (products[_productId].history, products[_productId].timestamps);
    }
}
