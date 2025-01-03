// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract BillSplitter {
   error InvalidAmount(uint256 amount);
   error InvalidPeopleCount(uint256 people);
   error CannotSplitEvenly(uint256 amount, uint256 people);
   
   function splitExpense(uint256 totalAmount, uint256 numPeople) public pure returns (uint256) {
       if (totalAmount == 0) {
           revert InvalidAmount(totalAmount);
       }
       if (numPeople == 0) {
           revert InvalidPeopleCount(numPeople);
       }
       if (totalAmount % numPeople != 0) {
           revert CannotSplitEvenly(totalAmount, numPeople);
       }
       
       return totalAmount / numPeople;
   }
}