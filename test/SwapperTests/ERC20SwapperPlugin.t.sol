// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../RootTests.t.sol";

contract TestSwapperPlugin is RootTest {
    ERC20Swapper erc20Swapper;
    address plugin;
    address plugin2;

    function setUp() public {
        plugin = address(new Uniswapper(WETH, ROUTER));
        plugin2 = address(new Uniswapper(WETH, ROUTER));
        erc20Swapper = new ERC20Swapper(address(this), address(plugin));
    }

    function testSwapEtherToToken() public {
        erc20Swapper.swapEtherToToken{value: 0.1 ether}(DAI, 1);
    }

    function testFailSwapEtherToToken() public {
        erc20Swapper.swapEtherToToken{value: 0.1 ether}(DAI, 1e23);
        vm.expectRevert();
    }

    function testUpdatePlugin() public {
        erc20Swapper.updatePlugin(plugin2);
    }
}
