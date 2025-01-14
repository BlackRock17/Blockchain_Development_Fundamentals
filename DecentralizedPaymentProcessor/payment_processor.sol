// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PaymentProcessor {

    mapping(address => uint256) public balances;

    event PaymentReceived(address indexed customer, uint256 amount);
    event RefundProcessed(address indexed customer, uint256 amount);

    
}