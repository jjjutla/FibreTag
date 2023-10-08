require('@nomiclabs/hardhat-waffle')
require('@vechain.energy/hardhat-thor')
require('hardhat-jest-plugin')
require('hardhat-contract-sizer')

module.exports = {
  solidity: {
    version: '0.8.9',
    settings: {
      optimizer: {
        enabled: true,
        runs: 2 ** 32 - 1
      }
    }
  },
  networks: {
    vechain: {
      url: 'https://testnet.veblocks.net',
      privateKey: '0x97ffdf95010a2446dced9757b0a37708d7f11df7aa327c64a8b5807723fa8d08',
      delegateUrl: 'https://sponsor-testnet.vechain.energy/by/90',
      gasPrice: 25000000,
      gas: 25000000
    }
  }
}
