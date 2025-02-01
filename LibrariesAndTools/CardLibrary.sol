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

    function removeAt(Card[] storage cards, uint256 index) internal {
        
        require(index < cards.length, "Index out of bounds");
        
        
        if (index == cards.length - 1) {
            cards.pop();
            return;
        }
        
        
        cards[index] = cards[cards.length - 1];
        
        cards.pop();
    }
}