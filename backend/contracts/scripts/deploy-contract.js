const hre = require('hardhat')
const Spinner = require('./modules/Spinner')
const getNetworkName = require('./modules/getNetworkName')
const { writeFileSync, existsSync, mkdirSync } = require('fs')
const { ARTIFACTS_DIR } = require('./modules/constants')

async function main () {
  const contractNames = process.argv.slice(2)

  if (!contractNames.length) {
    throw new Error('No contract names for deployment given')
  }

  const network = await getNetworkName(hre)
  console.log(`\nDeploying to **${String(network).toUpperCase()}** network\n`)

  const networkArtifactsDir = `${ARTIFACTS_DIR}/${network}`
  if (!existsSync(networkArtifactsDir)) {
    mkdirSync(networkArtifactsDir, { recursive: true })
  }

  for (const contractName of contractNames) {
    const deploying = Spinner(`[${contractName}] Deploying Contract `)
    const Contract = await hre.thor.getContractFactory(contractName)
    const { abi } = await hre.artifacts.readArtifact(contractName)

    const deployedContract = await Contract.deploy()
    await deployedContract.deployed()

    writeFileSync(`${networkArtifactsDir}/${contractName}.json`, JSON.stringify({ address: deployedContract.address, abi }, '', 2))

    deploying.info(`[${contractName}] Artifact written to ${networkArtifactsDir}/${contractName}.json`)
    deploying.info(`[${contractName}] Transaction Id: ${deployedContract.deployTransaction.hash}`)
    deploying.succeed(`[${contractName}] Contract is now available at ${deployedContract.address}\n`)
  }
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
