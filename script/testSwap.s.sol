// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.20;

// import "forge-std/Script.sol";
// import "../src/ERC20Swapper.sol";  // Update the path according to your project structure

// contract SwapEtherToToken is Script {
//     address public swapperAddress = 0x177cEfE3037D3af2757a3aFDad9bd4C1c3155a45;  // Replace with your deployed contract address

//     function run() external {
//         ERC20Swapper swapper = ERC20Swapper(swapperAddress);

//         address tokenAddress = 0x...;  // The token address you want to swap to
//         uint256 minAmount = 1 ether;  // Minimum amount of tokens you expect to receive

//         vm.startBroadcast();
//         // Call the swapEtherToToken function
//         // msg.value is the amount of Ether you want to swap
//         swapper.swapEtherToToken{value: 1 ether}(tokenAddress, minAmount);
//         vm.stopBroadcast();
//     }
// }
