// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Voting {

    struct Voter {
        bool hasVoted;
        uint256 choice;
    }

    mapping(address => Voter) public voters;

    event VoteRegistered(address voter, uint256 choice);

    function registerVote(uint256 _candidateId) public {
        require(!voters[msg.sender].hasVoted, "You have already voted!");

        voters[msg.sender] = Voter({
            hasVoted: true,
            choice: _candidateId
        });
    }
}