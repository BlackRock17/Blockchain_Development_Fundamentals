// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

interface ILoyaltyPoints {
    
    function rewardPoints(address customer, uint256 amount) external returns (bool);

    function redeemPoints(uint256 amount) external returns (bool);

    event Rewarded(address indexed customer, uint256 amount);

    event Redeemed(address indexed customer, uint256 amount);
}

abstract contract BaseLoyaltyProgram is ILoyaltyPoints {

    mapping(address => bool) public partners;

    modifier onlyPartner() {
        require(partners[msg.sender], "Not authorized partner");
        _;
    }
}