// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract LoanCalculator{
    error InvalidInterestRate(uint rate);
    error InvalidLoanPeriod(uint period);

    function calculateTotalPayable(uint256 principal, uint256 interestRate, uint256 loanPeriodYears) public pure returns (uint256) {
        if(interestRate == 0 || interestRate > 100) {
            revert InvalidInterestRate(interestRate);
        }

        if(loanPeriodYears < 1) {
            revert InvalidLoanPeriod(loanPeriodYears);
        }

        uint256 interest = (principal * interestRate * loanPeriodYears) / 100;

        return principal + interest;
    }
}