// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract DecentralizedSavings {

    struct SavingsAccount {
        uint256 balance;
        address owner;
        uint256 creationTime;
        uint256 lockPeriod;
    }

    mapping(address => SavingsAccount[]) private savingsAccounts;

    event SavingsPlanCreated(address indexed owner, uint256 planIndex, uint256 amount, uint256 lockPeriod);
    event FundsWithdrawn(address indexed owner, uint256 planIndex, uint256 amount);

    modifier onlyPlanOwner(uint256 _planIndex) {
        require(_planIndex < savingsAccounts[msg.sender].length, "Invalid plan index");
        require(savingsAccounts[msg.sender][_planIndex].owner == msg.sender, "Not the plan owner");
        _;
    }

    function createSavingsPlan(uint256 _lockPeriod) external payable {
        require(msg.value > 0, "Must deposit some ether");
        require(_lockPeriod > 0, "Lock period must be greater than 0");

        SavingsAccount memory newAccount = SavingsAccount({
            balance: msg.value,
            owner: msg.sender,
            creationTime: block.timestamp,
            lockPeriod: _lockPeriod
        });

        savingsAccounts[msg.sender].push(newAccount);

        emit SavingsPlanCreated(msg.sender, savingsAccounts[msg.sender].length - 1, msg.value, _lockPeriod);
    }

    function viewSavingsPlan(uint256 _planIndex)
        external 
        view
        onlyPlanOwner(_planIndex)
        returns (
            uint256 balance,
            address owner,
            uint256 creationTime,
            uint256 lockPeriod,
            bool isLocked,
            uint256 remainingTime
        )
    {
        SavingsAccount storage plan = savingsAccounts[msg.sender][_planIndex];

        uint256 endTime = plan.creationTime + plan.lockPeriod;
        bool locked = block.timestamp < endTime;
        uint256 remaining = locked ? endTime - block.timestamp : 0;

        return (
            plan.balance,
            plan.owner,
            plan.creationTime,
            plan.lockPeriod,
            locked,
            remaining
        );
    }
}