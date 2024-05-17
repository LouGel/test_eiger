// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ERC20SwapperPlugin.sol";
import "../src/plugins/Uniswapper.sol";

interface Router {
    function WETH9() external view returns (address);
}

contract DeployERC20Swapper is Script {
    function run() external {
        vm.startBroadcast();

        address ROUTER = 0x3bFA4769FB09eefC5a80d6E87c3B9C650f7Ae48E; //  SEPOLIA
        address WETH = address(Router(ROUTER).WETH9());
        address USDC = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238;
        // address OWNER = address(this); // Deployer

        address plugin = address(new Uniswapper(WETH, ROUTER));

        ERC20Swapper swapper = new ERC20Swapper(msg.sender, plugin);

        swapper.swapEtherToToken{value: 0.1 ether}(USDC, 1);
        vm.stopBroadcast();
    }
}
