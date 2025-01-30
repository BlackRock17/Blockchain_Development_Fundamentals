// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

struct Card {
    uint256 id;
    string name;
    address owner;
}

library CardLibrary {
    function exists(Card[] memory cards, uint256 id) internal pure returns (bool) {
        for (uint i = 0; i < cards.length; i++) {
            if (cards[i].id == id) {
                return true;
            }
        }
        return false;
    }
}