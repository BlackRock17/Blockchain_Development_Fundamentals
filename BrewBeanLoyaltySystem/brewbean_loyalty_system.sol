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

    function addPartner(address partner) external onlyPartner {
        partners[partner] = true;
    }

    function rewardPoints(address customer, uint256 amount) external override onlyPartner returns (bool) {
        require(_authorizeReward(customer, amount), "Reward not authorized");
        _mint(customer, amount);
        emit Rewarded(customer, amount);
        return true;
    }

    function redeemPoints(uint256 amount) external override returns (bool) {
        require(balanceOf(msg.sender) >= amount, "Insufficient points");
        _burn(msg.sender, amount);
        emit Redeemed(msg.sender, amount);
        return true;
    }
}