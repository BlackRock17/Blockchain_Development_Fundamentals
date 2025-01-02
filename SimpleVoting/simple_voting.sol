// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum VotingOptions {
    CandidateOne,
    CandidateTwo
}

error InvalidCandidate();

contract SimpleVoting {
    address public candidade1;
    address public candidade2;

    uint public votesCandidateOne;
    uint public votesCandidateTwo;

    function vote(address candidate) external {
        if(candidate == candidade1) {
            votesCandidateOne += 1;
        } else if(candidate == candidade2) {
            votesCandidateOne++;
        } else {
            revert InvalidCandidate();
        }
    }
}