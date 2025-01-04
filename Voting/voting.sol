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

        emit VoteRegistered(msg.sender, _candidateId);
    }

    function getVoterStatus(address _voter) public view returns (bool hasVoted, uint256 choice) {
        Voter memory voter = voters[_voter];
        return (voter.hasVoted, voter.choice);
    }
}