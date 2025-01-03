// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract GoalTracker {
   uint256 public goal;
   uint256 public baseReward;
   uint256 public totalSpent;
   bool public rewardClaimed;
   
   error GoalNotReached();
   error RewardAlreadyClaimed();
   error InvalidAmount();
   
   constructor(uint256 _goal, uint256 _baseReward) {
       goal = _goal;
       baseReward = _baseReward;
   }
   
   function addSpending(uint256 amount) public {
       if (amount == 0) {
           revert InvalidAmount();
       }
       totalSpent += amount;
   }
   
   function calculateReward() public view returns (uint256) {
       uint256 totalReward = 0;
       for(uint256 i = 0; i < 5; i++) {
           totalReward += baseReward;
       }
       return totalReward;
   }
   
   function claimReward() public returns (uint256) {
       if (totalSpent < goal) {
           revert GoalNotReached();
       }
       if (rewardClaimed) {
           revert RewardAlreadyClaimed();
       }
       
       rewardClaimed = true;
       return calculateReward();
   }
}