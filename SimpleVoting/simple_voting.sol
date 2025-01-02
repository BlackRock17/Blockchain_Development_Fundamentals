// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum VotingOptions {
    CandidateOne,
    CandidateTwo
}

contract SimpleVoting {
    uint256 public candidade1;
    uint256 public candidade2;

    function vote(VotingOptions candidate) external {
        if(candidate == VotingOptions.CandidateOne) {
            candidade1 += 1;
        } else if(candidate == VotingOptions.CandidateTwo) {
            candidade2++;
        } 
    }
}