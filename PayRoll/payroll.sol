// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PayrollCalculator {
   error InvalidSalary(uint256 salary);
   error InvalidRating(uint256 rating);
   
   function calculatePaycheck(uint256 salary, uint256 rating) public pure returns (uint256) {
       if (salary == 0) {
           revert InvalidSalary(salary);
       }
       if (rating > 10) {
           revert InvalidRating(rating);
       }
       
       if (rating > 8) {
           uint256 bonus = (salary * 10) / 100;
           return salary + bonus;
       }
       
       return salary;
   }
}