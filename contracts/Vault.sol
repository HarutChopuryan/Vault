// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC4626} from "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";
import {GnosisSafeActions} from "../script/helpers/GnosisSafeActions.sol";
import {IPool} from "./interfaces/IPool.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract Vault is ERC4626, Ownable {

    struct PoolInfo {
        address pool;
        uint8 allocPoint;
    }
    
    uint128 public totalPools;
    uint128 public totalAllocPoint;
    mapping(uint256 => PoolInfo) public poolInfo; // pid => PoolInfo

    constructor(IERC20 asset_) ERC20("Vault", "VLT") ERC4626(asset_) Ownable(msg.sender) {

    }

    function addPool(
        address pool_,
        uint8 allocPoint_
    ) external onlyOwner() {
        PoolInfo storage poolInfo_ = poolInfo[totalPools];
        poolInfo.pool = pool_;
        poolInfo.allocPoint = allocPoint_;
        totalPools++;
        totalAllocPoint += allocPoint_;
    }

    removePool

    function deposit(
        uint256 assets, 
        address receiver
    ) public override returns (uint256 shares) {
        shares = previewDeposit(assets);
        super.deposit(assets, receiver);
        // safeActions.approve(asset(), address(yldrPool), assets);
        // IERC20(asset()).transfer(address(safeProxy), assets);
        // safeActions.deposit(asset(), assets, address(safeProxy), 0);
    }

    function mint(
        uint256 shares, 
        address receiver
    ) public override returns (uint256 assets) {
        assets = previewMint(shares);
        super.mint(shares, receiver);
        // safeActions.approve(asset(), address(yldrPool), assets);
        // IERC20(asset()).transfer(address(safeProxy), assets);
        // safeActions.deposit(asset(), assets, address(safeProxy), 0);
    }

    function withdraw(
        uint256 assets, 
        address receiver, 
        address owner
    ) public override returns (uint256 shares) {
        shares = previewWithdraw(assets);
        // safeActions.withdraw(asset(), assets, address(safeProxy));
        // safeActions.transfer(asset(), address(this), assets);
        super.withdraw(assets, receiver, owner);
    }

    function redeem(
        uint256 shares, 
        address receiver, 
        address owner
    ) public override returns (uint256 assets) {
        // safeActions.withdraw(asset(), shares, address(safeProxy));
        // safeActions.transfer(asset(), address(this), shares);
        super.redeem(shares, receiver, owner);
        assets = previewRedeem(shares);
    }
}
