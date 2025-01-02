// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

enum VotingOptions {
    CandidateOne,
    CandidateTwo
}

error InvalidCandidate();

contract SimpleVoting {
    bool public votingEnded = false;
    address public candidade1;
    address public candidade2;

    uint public votesCandidateOne;
    uint public votesCandidateTwo;

    function vote(address candidate) external {
        require(!votingEnded, "Voting has already ended!");
        if(candidate == candidade1) {
            votesCandidateOne += 1;
        } else if(candidate == candidade2) {
            votesCandidateOne++;
        } else {
            revert InvalidCandidate();
        }
    }
}