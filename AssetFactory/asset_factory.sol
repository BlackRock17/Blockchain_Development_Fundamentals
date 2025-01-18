// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Asset {
    string public symbol;
    string public name;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;
    
}