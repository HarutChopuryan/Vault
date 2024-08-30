//SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.0;

/**
 * @title DefiProtocol
 * @author Protofire
 * @dev Abstract contract defining common interface for every supported protocols.
 *
 */

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

abstract contract ProtocolAdapter {
    string public protocolAadapterName;
    IERC20 public asset;

    constructor(string memory _prtocolAdaterName, IERC20 asset_) {
        protocolAadapterName = _prtocolAdaterName;
        asset = asset_;
    }

    // TODO: what to do if DEBT is bigger than current gross Value??? -- revert deposits/widrawal*/
    function getNetAssetValue(address _target) external view returns (uint256) {
        return getGrossValue(_target) - getGrossDebt(_target);
    }

    // Primitive to be implemented by childs
    function getGrossDebt(
        address
    ) public view virtual returns (uint256 grossDebt) {
        return 0;
    }

    // Primitive to be implemented by childs
    function getGrossValue(
        address _target
    ) public view virtual returns (uint256 grossValue);
}
