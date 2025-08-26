# Foundry ERC20 Study Repository

This repository is a hands-on project for studying and understanding the ERC20 token standard using the [Foundry](https://github.com/foundry-rs/foundry) development framework.

It features a basic ERC20 token (`OurToken`) that inherits from the battle-tested OpenZeppelin ERC20 implementation. The project includes setup, testing, and deployment scripts, making it an excellent starting point for learning about token development on Ethereum.

## Project Overview

- **`OurToken.sol`**: A simple ERC20 token with a fixed initial supply minted to the deployer. It inherits from OpenZeppelin's `ERC20.sol` contract, providing all standard functionalities out-of-the-box.
- **Foundry Framework**: All contracts are built, tested, and deployed using Foundry.
- **Comprehensive Tests**: The `test/` directory contains tests for core functionalities like initial supply, transfers, and failure cases.
- **Makefile Scripts**: The `Makefile` provides convenient shortcuts for common tasks like installation, testing, and deployment.

## Tech Stack

- **Solidity** (v0.8.18)
- **Foundry**
- **OpenZeppelin Contracts** (v5.0.2)

## Getting Started

### Prerequisites

- [**Foundry**](https://book.getfoundry.sh/getting-started/installation): Ensure you have Foundry installed. You can install it with the following command:
  ```bash
  curl -L https://foundry.paradigm.xyz | bash
  ```
  Then, in a new terminal session or after reloading your shell, run `foundryup` to install the latest version.

### Installation

1.  **Clone the repository:**
    ```bash
    git clone <YOUR_REPOSITORY_URL>
    cd foundry-erc20-f23
    ```

2.  **Install dependencies:**
    This project uses `forge-std` and `openzeppelin-contracts`. Install them using Foundry's package manager:
    ```bash
    forge install
    ```
    Alternatively, you can use the Makefile command:
    ```bash
    make install
    ```

## Usage

### Build

Compile the smart contracts using the `build` command:

```bash
forge build
```

### Test

Run the test suite to ensure all contract functionalities are working as expected:

```bash
forge test
```

### Run a Local Node

To deploy and interact with the contracts locally, start a local Anvil node in a separate terminal:

```bash
make anvil
```

This will start a local blockchain instance with pre-funded accounts.

### Deploy

With the Anvil node running, deploy the `OurToken` contract to your local network using the provided script. Open a new terminal and run:

```bash
make deploy
```

This command executes the `script/DeployOurToken.s.sol` script, which deploys the contract and broadcasts the transaction to the local Anvil node.

## Makefile Commands

The `Makefile` contains several helpful commands to streamline the development workflow:

| Command           | Description                                                                  |
| ----------------- | ---------------------------------------------------------------------------- |
| `make install`    | Installs the necessary dependencies (`forge-std`, `openzeppelin-contracts`). |
| `make all`        | Cleans, installs, updates, and builds the project.                           |
| `make build`      | Compiles the contracts.                                                      |
| `make test`       | Runs the test suite.                                                         |
| `make anvil`      | Starts a local Anvil development node.                                       |
| `make deploy`     | Deploys the `OurToken` contract to the local Anvil node.                     |
| `make deploy-sepolia` | Deploys the contract to the Sepolia testnet (requires `.env` file).        |
| `make clean`      | Cleans the project's build artifacts and cache.                              |
| `make format`     | Formats the Solidity code using `forge fmt`.                                 |

---

This project is intended for educational purposes. Feel free to experiment, add new features, and expand the test suite to deepen your understanding of ERC20 tokens and smart contract development.

