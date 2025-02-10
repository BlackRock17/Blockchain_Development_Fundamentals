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

}