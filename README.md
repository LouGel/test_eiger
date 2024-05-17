# ERC20 Swapper Contracts

This repository contains two smart contract implementations for swapping Ether to ERC20 tokens using Uniswap: the UUPS Swapper and the Plugin Swapper. Both implementations allow for upgradable contracts but use different approaches with varying gas costs.

## Table of Contents

- [Introduction](#introduction)
- [Contracts](#contracts)
  - [ERC20SwapperUUPSV1](#erc20swapperuupsv1)
  - [ERC20SwapperPlugin](#erc20swapperplugin)
- [Deployment and Gas Costs](#deployment-and-gas-costs)
  - [UUPS Swapper](#uups-swapper)
  - [Plugin Swapper](#plugin-swapper)
- [Conclusion](#conclusion)

## Introduction

The ERC20 Swapper contracts facilitate the swapping of Ether to ERC20 tokens using Uniswap. The repository includes two implementations:

1. **UUPS Swapper**: Utilizes the UUPS proxy pattern for upgradability.
2. **Plugin Swapper**: Uses a plugin system for swap logic, allowing the main contract to delegate calls to the plugin.

## Contracts

### ERC20SwapperUUPSV1

The UUPS Swapper contract implements the UUPS proxy pattern, which allows for upgradable smart contracts with lower gas costs for upgrades. It leverages storage variables for configuration.

### ERC20SwapperPlugin

The Plugin Swapper contract separates the swap logic into a plugin contract, which the main contract delegates calls to. This approach uses constants and immutables, which can lead to different gas costs compared to the UUPS pattern.

## Deployment and Gas Costs (Mainnet fork 05/17/2024 13h)

### UUPS Swapper

1. **Deployment of Implementation**: ~`760,788` gas
2. **Deployment and Initialization of Proxy**: ~`155,232` gas (initialization: `95,774` gas)
3. **Swap Execution**: ~`132,605` gas
4. **Upgrade Call (without considering implementation or initializer)**: ~`23,196` gas

### Plugin Swapper

1. **Deployment of Plugin**: Approximately ~`135,404` gas
2. **Deployment of Main Contract**: Approximately ~`421,313` gas
3. **Swap Execution**: Approximately ~`129,260` gas (may vary)
4. **Upgrade Call (without considering new implementation)**: ~`17,950` gas

The main difference in gas costs for swaps is due to the UUPS Swapper relying on variables, while the Plugin Swapper uses constants and immutables, which are optimized at compile time.

## Conclusion

Different approaches can be taken when designing upgradeable contracts. The UUPS (Universal Upgradeable Proxy Standard) pattern is commonly used due to its flexibility and ease of use. However, using a full proxy can present security issues, such as the potential approval of an unintended contract.

Alternatively, the plugin pattern can be beneficial if only one or two functions require upgradability. However, it lacks the flexibility and comprehensive upgrade capabilities that the UUPS pattern offers
