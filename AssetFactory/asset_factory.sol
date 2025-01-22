// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./asset.sol"

contract AssetFactory {
    mapping(string => address) public assets;

    event AssetCreated(string symbol, address AssetAddress);
    event TransferExecuted(string symbol, address from, address to, uint256 amount);

    function createAsset(
        string memory _symbol,
        string memory _name,
        uint256 _initialSupply
    ) external returns (address) {
        require(assets[_symbol] == address(0), "Asset with this symbol already exist");

        Asset newAsset = new Asset(_symbol, _name, _initialSupply);
        assets[_symbol] = address(newAsset);

        emit AssetCreated(_symbol, address(newAsset));
        return address(newAsset);
    }
}