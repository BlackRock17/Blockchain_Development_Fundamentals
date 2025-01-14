// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./payment_processor.sol";

contract Merchant is PaymentProcessor {

    uint256 public constant LOYALTY_THRESHOLD = 1 ether;

    uint256 public constant LOYALTY_BONUS_PERCENT = 1;

    event LoyaltyBonusApplied(address indexed customer, uint256 bonusAmount);

    function refundPayment(uint256 amount) public override {

        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Refund amount must be greater than 0");

        uint256 totalRefund = amount;

        if (balances[msg.sender] >= LOYALTY_THRESHOLD) {

            uint256 bonus = (amount * LOYALTY_BONUS_PERCENT) / 100;
            totalRefund += bonus;

            require(balances[msg.sender] >= totalRefund, "Insufficient balance for bonus");
            emit LoyaltyBonusApplied(msg.sender, bonus);
        }

        balances[msg.sender] -= totalRefund;
        payable(msg.sender).transfer(totalRefund);

        emit RefundProcessed(msg.sender, totalRefund); 
    }
}