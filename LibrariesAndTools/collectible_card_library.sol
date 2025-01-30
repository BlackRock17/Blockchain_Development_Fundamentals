// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./CardLibrary.sol";

contract CollectibleCardLibrary {
    using CardLibrary for Card[];

    mapping(address => Card[]) private collections;

    event CardAdded(address indexed owner, uint256 id, string name);

    function addCard(uint256 id, string memory name) public {
       // Check if the card already exists in the user's collection
        require(!collections[msg.sender].exists(id), "Card with this ID already exists in your collection");
        
        // Create a new map
        Card memory newCard = Card({
            id: id,
            name: name,
            owner: msg.sender
        });
        
        // Add the card to the user's collection
        collections[msg.sender].push(newCard);
        
        // Emit an event for the added card
        emit CardAdded(msg.sender, id, name);
    }
}