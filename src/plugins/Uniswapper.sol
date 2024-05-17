// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/IUniswapRouter02.sol";

/// @title Uniswapper Contract
/// @notice This contract allows for swapping Ether to a specified token using Uniswap.
/// @dev Utilizes delegatecall for enhanced functionality.
contract Uniswapper {
    /// @notice Check made by the delegator contract avoiding, misset.
    bool public constant isSwapperPlugin = true;

    /// @notice Stores the address of this contract for delegatecall verification.
    address immutable _this;
    address immutable WETH;

    IUniswapRouter02 immutable router;

    /// @param _router The address of the Uniswap router.
    constructor(address _weth, address _router) {
        _this = address(this);
        WETH = _weth;
        router = IUniswapRouter02(_router);
    }

    function swapEtherToToken(address token, uint256 minAmount) public payable returns (uint256 amountOut) {
        require(_this != address(this), "Only DelegateCall");

        IUniswapRouter02.ExactInputSingleParams memory input = IUniswapRouter02.ExactInputSingleParams({
            tokenIn: WETH,
            tokenOut: token,
            fee: 3000,
            recipient: msg.sender,
            amountIn: msg.value,
            amountOutMinimum: minAmount,
            sqrtPriceLimitX96: 0
        });

        return router.exactInputSingle{value: msg.value}(input);
    }
}
