// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

/**
 * @title ERC20SwapperUUPSV2
 * @dev Test for upgrade
 */
contract ERC20SwapperUUPSV2 is Initializable, OwnableUpgradeable, UUPSUpgradeable, PausableUpgradeable {
    address payable public WETH;
    address public router;

    constructor() initializer {}

    function swapEtherToToken(address, uint256) external payable virtual returns (uint256 amountOut) {
        return uint256(bytes32(bytes20(router)));
    }

    function _authorizeUpgrade(address newImplementation) internal override onlyOwner {}
}
