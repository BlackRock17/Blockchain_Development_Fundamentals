// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./NumLib.sol";

contract PartyChecker {
    using NumLib for uint256;

    function checkParty(uint256 value) public pure returns (bool) {
        return value.isEven();
    }
}