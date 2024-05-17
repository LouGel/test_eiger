// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;
/**
 * @title IUniswapRouter02
 * @dev Interface for Uniswap V3 Router02 (without deadline) to handle token swaps.
 */

interface IUniswapRouter02 {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);
}
