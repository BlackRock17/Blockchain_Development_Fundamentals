// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract VotingEligibility {
    error TooYoungToVote(uint age);

    function checkEligibility(uint age) public pure returns (bool) {
        if(age < 18) {
            revert TooYoungToVote(age);
        }

        return true;
    }
}