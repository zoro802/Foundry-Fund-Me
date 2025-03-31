Foundry Fund Me Project

This repository contains the source code, scripts, and tests for the Foundry Fund Me project—a demonstration of deploying and interacting with a smart contract that uses Chainlink Price Feeds to fund and withdraw ETH. The project is built using Foundry and includes official Chainlink dependencies.
Table of Contents

    Requirements

    Quickstart

    Usage

        Deploying the Contract

        Testing

        Test Coverage

        Local zkSync Deployment

    Additional Information

    Chainlink Dependencies

    License

Requirements

    Git
    Verify installation by running:

git --version

You should see output similar to: git version x.x.x.

Foundry
Verify installation by running:

forge --version

Expected output: forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z) (version may vary).

Optional Tools:

    foundry-zksync (for local zkSync development)

    npm & npx
    Verify by running:

npm --version
npx --version

Docker
Verify installation by running:

        docker --version

Quickstart

    Clone the repository:

git clone https://github.com/Cyfrin/foundry-fund-me-cu
cd foundry-fund-me-cu

Build the project by running:

    make

Optional Gitpod

If you prefer to work in Gitpod, open this repository in Gitpod and skip the clone step.

Open in Gitpod
Usage
Deploy

To deploy the FundMe contract, run:

forge script script/DeployFundMe.s.sol

Deploy to a Testnet or Mainnet

Before deploying, set up your environment variables:

    PRIVATE_KEY: The private key of your account (use a development key, not one with real funds).

    SEPOLIA_RPC_URL: The RPC URL for the Sepolia testnet (obtain one for free from Alchemy or Infura).

    ETHERSCAN_API_KEY (Optional): For verifying your contract on Etherscan.

Then deploy using:

forge script script/DeployFundMe.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_API_KEY

Testing

This project covers Unit Tests and Forked Tests.

    To run all tests:

forge test

To run a specific test matching a pattern:

forge test --match-test testFunctionName

To run tests on a forked network (e.g., Sepolia):

    forge test --fork-url $SEPOLIA_RPC_URL

Test Coverage

To get a detailed gas snapshot and test coverage report, run:

forge coverage

This will generate an output file (e.g., .gas-snapshot) showing gas usage and coverage metrics.
Local zkSync Deployment

If you want to deploy and test on a local zkSync node, follow these steps:

    Install foundry-zksync.

    Run:

npx zksync-cli dev config

and select: In memory node and do not select any additional modules.

Start the zkSync node:

npx zksync-cli dev start

You should see output similar to:

In memory node started v0.1.0-alpha.22:
 - zkSync Node (L2):
   - Chain ID: 260
   - RPC URL: http://127.0.0.1:8011
   - Rich accounts: https://era.zksync.io/docs/tools/testing/era-test-node.html#use-pre-configured-rich-wallets

To deploy to the local zkSync node:

    make deploy-zk

Additional Information
Scripts

After deploying to a testnet or local network, you can interact with your contract using scripts:

    To fund the contract:

forge script script/Interactions.s.sol:FundFundMe --rpc-url sepolia --private-key $PRIVATE_KEY --broadcast

To withdraw funds:

    forge script script/Interactions.s.sol:WithdrawFundMe --rpc-url sepolia --private-key $PRIVATE_KEY --broadcast

Alternatively, using cast:

cast send <FUNDME_CONTRACT_ADDRESS> "fund()" --value 0.1ether --private-key <PRIVATE_KEY>
cast send <FUNDME_CONTRACT_ADDRESS> "withdraw()" --private-key <PRIVATE_KEY>

Formatting

To format your code, run:

forge fmt

Chainlink Dependencies

This project uses the official Chainlink Brownie Contracts repository maintained by Chainlink.
Note: Chainlink contracts are published officially via npm. This repository wraps them for Foundry usage.
What is Foundry DevOps?

Foundry DevOps is a set of tools designed to streamline development workflows with Foundry. It helps with automation for deployments, testing, and integration with CI/CD pipelines.

To install Foundry DevOps, run:

forge install Cyfrin/foundry-devops --no-commit

If you encounter issues regarding embedded Git repositories, ensure your project is a Git repository and remove any unwanted embedded repositories using:

git rm --cached -r lib/chainlink-brownie-contracts

License

This project is licensed under the MIT License