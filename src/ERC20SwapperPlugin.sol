// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";

/// @title ISwapperPlugin Interface
/// @notice Interface to check if a contract is a valid swapper plugin.
interface ISwapperPlugin {
    function isSwapperPlugin() external pure returns (bool);
}

/// @title ERC20Swapper Contract
/// @notice This contract facilitates swapping Ether to ERC20 tokens using a plugin.
contract ERC20Swapper is Ownable, Pausable {
    /// @notice Address of the current swapper plugin.
    address public plugin;

    /// @notice Initializes the contract with an owner and a swapper plugin.
    /// @param owner The address of the contract owner.
    /// @param _plugin The address of the swapper plugin.
    constructor(address owner, address _plugin) Ownable(owner) {
        transferOwnership(owner);
        if (!ISwapperPlugin(_plugin).isSwapperPlugin()) revert PluginError("WrongPlugin");
        plugin = _plugin;
    }

    function swapEtherToToken(address token, uint256 minAmount)
        external
        payable
        whenNotPaused
        returns (uint256 amountOut)
    {
        bytes memory data = abi.encodeWithSignature("swapEtherToToken(address,uint256)", token, minAmount);
        (bool success, bytes memory returnData) = address(plugin).delegatecall(data);

        if (!success) {
            (string memory reason) = abi.decode(returnData, (string));
            revert PluginError(reason);
        }
        amountOut = abi.decode(returnData, (uint256));
        emit EtherSwapped(msg.value, amountOut, token);
    }

    /// @notice Updates the address of the swapper plugin.
    function updatePlugin(address _plugin) external onlyOwner {
        if (!ISwapperPlugin(_plugin).isSwapperPlugin()) revert PluginError("WrongPlugin");
        plugin = _plugin;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    event EtherSwapped(uint256 amountIn, uint256 amountOut, address token);

    error PluginError(string reason);
}
