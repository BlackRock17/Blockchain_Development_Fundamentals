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

    function _authorizeReward(address customer, uint256 amount) internal virtual returns (bool) {
        require(customer != address(0), "Invalid customer address");
        require(amount > 0, "Amount must be positive");
        return true;
    }
}

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BrewBeanPoints is ERC20, BaseLoyaltyProgram {
    constructor() ERC20("BrewBean Points", "BBP") {
        partners[msg.sender] = true;
    }
}