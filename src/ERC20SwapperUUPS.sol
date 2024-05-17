// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

import "./interfaces/IUniswapRouter02.sol";

/**
 * @title ERC20SwapperUUPS
 * @dev Utilizes UUPS upgradeability pattern to avoid overdeployment costs and overcentralization of security.
 */
contract ERC20SwapperUUPS is Initializable, OwnableUpgradeable, UUPSUpgradeable, PausableUpgradeable {
    address payable public WETH;
    address public router;

    /// @notice Constructor is used to prevent misuse of the interface.
    constructor() initializer {}

    /// @notice Initializes the contract with WETH and router addresses.
    function initialize(address _weth, address _router, address owner) public initializer {
        WETH = payable(_weth);
        router = _router;
        __UUPSUpgradeable_init();
        __Ownable_init(owner);
        __Pausable_init();
    }

    function swapEtherToToken(address token, uint256 minAmount)
        external
        payable
        whenNotPaused
        returns (uint256 amountOut)
    {
        IUniswapRouter02.ExactInputSingleParams memory params = IUniswapRouter02.ExactInputSingleParams({
            tokenIn: WETH,
            tokenOut: token,
            fee: 3000,
            recipient: msg.sender,
            amountIn: msg.value,
            amountOutMinimum: minAmount,
            sqrtPriceLimitX96: 0
        });

        amountOut = IUniswapRouter02(router).exactInputSingle{value: msg.value}(params);

        emit EtherSwapped(msg.value, amountOut, token);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    /// @notice Authorizes contract upgrades, restricted to the contract owner.
    /// @param newImplementation The address of the new contract implementation.
    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}

    event EtherSwapped(uint256 amountIn, uint256 amountOut, address token);
}
