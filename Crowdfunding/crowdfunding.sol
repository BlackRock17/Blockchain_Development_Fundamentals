// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Crowdfunding {

    struct {
        uint256 goalAmound;
        uint256 totalCollected;
        uint256 endTime;
        bool goalReached;
        bool fundsClaimed;
    }

    Campaign public campaign;

    mapping(address => uint256) public contributions;

    
}