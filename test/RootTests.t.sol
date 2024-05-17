// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ERC20SwapperPlugin.sol";
import "../src/plugins/Uniswapper.sol";
import "../src/ERC20SwapperUUPS.sol";
import {ERC20SwapperUUPSV2} from "../src/ERC20SwapperUUPSV2.sol";
import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

contract RootTest is Test {
    address payable constant WETH = payable(address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2));
    address constant USDC = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    address constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
    address ROUTER = 0x68b3465833fb72A70ecDF485E0e4C7bD8665Fc45;
}
