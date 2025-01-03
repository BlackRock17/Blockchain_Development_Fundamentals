// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract ArithmeticCalculator {
    error DevisionByZero();

    function add(int a, int b) public pure returns (int) {
        return a + b;
    }

    function subtract(int a, int b) public pure returns (int) {
        return a - b;
    }

    function multiply(int a, int b) public pure returns (int) {
        return a * b;
    }

    function divide(int a, int b) public pure returns (int) {
        if(b == 0) {
            revert DevisionByZero();
        }

        return a / b;
    }
}