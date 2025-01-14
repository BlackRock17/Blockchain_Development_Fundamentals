// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./payment_processor.sol";

contract Merchant is PaymentProcessor {

    uint256 public constant LOYALTY_THRESHOLD = 1 ether;

    uint256 public constant LOYALTY_BONUS_PERCENT = 1;

    event LoyaltyBonusApplied(address indexed customer, uint256 bonusAmount);

    
}