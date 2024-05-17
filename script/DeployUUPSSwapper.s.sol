// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/ERC20SwapperUUPS.sol";
import "../src/ERC20SwapperUUPSV2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

interface Router {
    function WETH9() external view returns (address payable);
}

interface Erc20 {
    function symbol() external view returns (address payable);
}

contract DeployUUPSSwapper is Script {
    function run() public {
        vm.startBroadcast();

        address ROUTER = 0x3bFA4769FB09eefC5a80d6E87c3B9C650f7Ae48E; //  SEPOLIA
        address WETH = Router(ROUTER).WETH9(); //SEPOLIA
        address USDC = 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238; // SEPOLIA
        address OWNER = msg.sender;
        Erc20(USDC).symbol();

        bytes memory initData = abi.encodeCall(ERC20SwapperUUPS.initialize, (WETH, ROUTER, OWNER));
        address impl = address(new ERC20SwapperUUPS());
        address proxy = address(new ERC1967Proxy(address(impl), initData));

        ERC20SwapperUUPS(proxy).swapEtherToToken{value: 0.1 ether}(USDC, 1);

        vm.stopBroadcast();
    }
}
