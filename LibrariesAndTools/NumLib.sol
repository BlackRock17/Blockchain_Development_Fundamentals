// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

library NumLib {
    function isEven(uint256 self) public pure returns (bool) {
        return self % 2 == 0;
    }
}