const Web3 = require("web3");
const fs = require("fs");
const thorify = require("thorify").thorify;
const { exec } = require('child_process');

// import { setTimeout } from "timers/promises";

const web3 = thorify(new Web3(), "https://vethor-node-test.vechaindev.com");
const contractABI = require('./artifacts/contracts/supplychain.sol/supplychain.json');

const privateKey = "0x4d7e55bf9b375830288cc865b694a4abcfbd61d190c2824ce76bfe78643fd9c9"; 

web3.eth.accounts.wallet.add(privateKey);

const contractAddress = '0x0240Ea955Ca08C5258780965b617950FBAfb4A70';

const fashionContract = new web3.eth.Contract(contractABI.abi, contractAddress);

const nfcTagId = '123';

// async function createProduct(description) {
//     await fashionContract.methods.createProduct(description).send({ from: web3.eth.accounts.wallet[0].address });

//     const productId = await fashionContract.methods.productCount().call();
//     console.log(productId)
//     return productId;
// }
// Function to create a new product

function getCurrentTimestamp() {
    const now = new Date();

    // Ensure double-digit format for day, month, hours, minutes, and seconds
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');  // JS months are 0-indexed
    const date = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${date} ${hours}:${minutes}:${seconds}`;
}


async function createProduct(description) {
    const timestamp = await getCurrentTimestamp();
    await fashionContract.methods.createProduct(description, timestamp).send({ from: web3.eth.accounts.wallet[0].address });
    const productId = await fashionContract.methods.productCount().call();
    console.log(productId)
    return productId;
}

// Function to add a manufacturing stage to a product
async function addManufacturingStage(productId, stageName) {
    const timestamp = await getCurrentTimestamp();
    return fashionContract.methods.addManufacturingStage(productId, stageName, timestamp).send({ from: web3.eth.accounts.wallet[0].address });
}

// Function to start a manufacturing stage
async function startManufacturingStage(productId, stageIndex) {
    const timestamp = await getCurrentTimestamp();
    return fashionContract.methods.startManufacturingStage(productId, stageIndex, timestamp).send({ from: web3.eth.accounts.wallet[0].address });
}

// Function to complete a manufacturing stage
async function completeManufacturingStage(productId, stageIndex) {
    const timestamp = await getCurrentTimestamp();
    return fashionContract.methods.completeManufacturingStage(productId, stageIndex, timestamp).send({ from: web3.eth.accounts.wallet[0].address });
}

// Function to sell a product
async function sellProduct(productId, newOwnerAddress) {
    const timestamp = await getCurrentTimestamp();
    return fashionContract.methods.sellProduct(productId, newOwnerAddress, timestamp).send({ from: web3.eth.accounts.wallet[0].address });
}

// Function to get the history of a product
async function getHistory(productId) {
    console.log( await fashionContract.methods.getHistory(productId).call());
    return fashionContract.methods.getHistory(productId).call();
}

// createProduct("LV CHAIN")
// addManufacturingStage(6, "sewing")
// addManufacturingStage(6, "embroidering")
// addManufacturingStage(6, "packaging")

// startManufacturingStage(6,1)

// completeManufacturingStage(6,1)



// getHistory(6)


module.exports = {
    getHistory: getHistory,
    createProduct: createProduct,
    addManufacturingStage: addManufacturingStage,
};