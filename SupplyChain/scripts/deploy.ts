import { ethers } from "hardhat";

async function main() {
  const Supplychain = await ethers.getContractFactory("supplychain");

  const supplychain = await Supplychain.deploy();

  await supplychain.waitForDeployment();

  console.log(supplychain.target);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });