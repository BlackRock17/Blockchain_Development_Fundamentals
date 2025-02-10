// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./UniCoin.sol";
import "./SoftCoin.sol";

contract TokenExchange {
    SoftCoin public softCoin;
    UniCoin public uniCoin;

    uint256 public constant EXCHANGE_RATE = 1;

    event TokensTraded(address indexed trader, uint256 amount);

    constructor(address _softCoinAddress, address _uniCoinAddress) {
        softCoin = SoftCoin(_softCoinAddress);
        uniCoin = UniCoin(_uniCoinAddress);
    }

    function trade(uint256 amount) public {
        require(amount > 0, "Amount must be greater than 0");
        
        // Check if the merchant has enough SoftCoin
        require(
            softCoin.balanceOf(msg.sender) >= amount,
            "Insufficient SoftCoin balance"
        );
        
        // Transfer SoftCoin to this contract
        require(
            softCoin.transferFrom(msg.sender, address(this), amount),
            "SoftCoin transfer failed"
        );
        
        // Calculate the amount of UniCoin to mint
        uint256 uniCoinAmount = amount * EXCHANGE_RATE;
        
        // Mint UniCoin to the merchant
        uniCoin.mint(msg.sender, uniCoinAmount);
        
        emit TokensTraded(msg.sender, amount);
    }

    // Helper function for checking SoftCoin balance
     function getSoftCoinBalance(address account) public view returns (uint256) {
        return softCoin.balanceOf(account);
    }

    // Helper function for checking UniCoin balance
    function getUniCoinBalance(address account) public view returns (uint256) {
        return uniCoin.balanceOf(account);
    }
}