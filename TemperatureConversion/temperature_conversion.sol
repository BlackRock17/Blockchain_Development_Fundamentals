// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract TemperatureConverter {
    function toFahrenheit(int celsius) public pure returns (int) {
        return (celsius * 9/5) + 32;
    }

    function toCelsius(int fahrenheit) public pure returns (int) {
        return (fahrenheit - 32) * 5/9;
    }
}