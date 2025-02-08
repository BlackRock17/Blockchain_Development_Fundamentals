// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract SoftCoin is ERC20 {
    constructor() ERC20("SoftCoin", "SFT") {}

    function mint(uint256 amount) public {
        _mint(msg.sender, amount);
    }

}