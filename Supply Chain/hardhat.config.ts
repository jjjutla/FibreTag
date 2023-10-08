import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@vechain/hardhat-vechain";
import '@vechain/hardhat-ethers';

const file = require('./secretKey.json');
const secretKey = file.secretKey;


const config: HardhatUserConfig = {
  solidity: "0.8.20",
  networks: {
    vechain_testnet: {
      url: "https://node-testnet.vechain.energy",
      accounts: [secretKey],
      restful: true,
      gas: 10000000,
    },
  },
};

export default config;
