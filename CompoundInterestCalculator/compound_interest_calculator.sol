// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract CompoundInterestCalculator {
    error InvalidPrincipal();
    error InvalidRate();
    error InvalidYears();

    function calculateCompoundInterest(
        uint256 principal,
        uint256 rate,
        uint256 year
    ) public pure returns (uint256) {
        if (principal == 0) revert InvalidPrincipal();
        if (rate == 0 || rate > 100) revert InvalidRate();
        if (year == 0) revert InvalidYears();

        uint256 balance = principal;

        for (uint256 i = 0; i < year; i++) {
            uint256 interest = (balance * rate) / 100;
            balance += interest;
        }

        return balance;
    } 
}