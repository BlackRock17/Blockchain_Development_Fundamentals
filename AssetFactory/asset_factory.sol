// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./asset.sol"

contract AssetFactory {
    mapping(string => address) public assets;

    event AssetCreated(string symbol, address AssetAddress);
    event TransferExecuted(string symbol, address from, address to, uint256 amount);

    
}