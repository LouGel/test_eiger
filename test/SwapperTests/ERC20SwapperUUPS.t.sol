// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../RootTests.t.sol";

contract TestSwapperUUPS is RootTest {
    ERC20SwapperUUPS impl;

    address impl2;
    address proxy;

    function setUp() public {
        bytes memory initData = abi.encodeCall(ERC20SwapperUUPS.initialize, (WETH, ROUTER, address(this)));
        impl = new ERC20SwapperUUPS();
        impl2 = address(new ERC20SwapperUUPSV2());

        proxy = address(new ERC1967Proxy(address(impl), initData));

        console.log("Proxy deployed at:", proxy);

        console.log("Implementation V2 deployed at:", address(impl2));
    }

    function testSwapEtherToToken() public {
        ERC20SwapperUUPSV2(proxy).swapEtherToToken{value: 0.1 ether}(DAI, 1);
    }

    function testUpgradeUUPS() public {
        ERC20SwapperUUPS(proxy).upgradeToAndCall(impl2, "");
        // require(
        //     uint256(bytes32(bytes20(ROUTER))) == ERC20SwapperUUPSV2(proxy).swapEtherToToken(address(0), 1),
        //     "Memory issue"
        // );
        // console.log("Proxy upgraded");
    }
}
