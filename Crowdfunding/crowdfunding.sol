// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Crowdfunding {

    struct Campaign {
        uint256 goalAmound;
        uint256 totalCollected;
        uint256 endTime;
        bool goalReached;
        bool fundsClaimed;
    }

    Campaign public campaign;

    mapping(address => uint256) public contributions;

    event ContributionMade(address contributor, uint256 amount);
    event GoalReached(uint256 totalAmount);
    event RefundClaimed(address contributor, uint256 amount);

    constructor(uint256 _goalAmound, uint256 _durationInDays) {
        require(_goalAmound > 0, "Goal amount must be greater than 0");
        require(_durationInDays > 0, "Duration must be greater than 0");

        campaign = Campaign({
            goalAmound: _goalAmound,
            totalCollected: 0,
            endTime: block.timestamp + (_durationInDays * 1 days),
            goalReached: false,
            fundsClaimed: false
        });
    }

    function contribute() external payable {
        require(block.timestamp > campaign.endTime, "Campaign has ended");
        require(msg.value > 0, "Contribution must be greater than 0");

        contributions[msg.sender] += msg.value;
        campaign.totalCollected += msg.value;

        emit ContributionMade(msg.sender, msg.value);

        checkGoalReached();
    }

    function checkGoalReached() public {
        if(!campaign.goalReached && campaign.totalCollected >= campaign.goalAmound) {
            campaign.goalReached = true;
            emit GoalReached(campaign.totalCollected);
        }
    }
}