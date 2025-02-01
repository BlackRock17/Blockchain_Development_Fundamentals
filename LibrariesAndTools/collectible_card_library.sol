// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "./CardLibrary.sol";

contract CollectibleCardLibrary {
    using CardLibrary for Card[];

    address private immutable owner;

    mapping(address => Card[]) private collections;

    event CardAdded(address indexed owner, uint256 id, string name);
    event CardRemoved(address indexed owner, uint256 id, string name);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }

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

    function removeCardAt(uint256 index) public onlyOwner {
        Card[] storage userCards = collections[msg.sender];
        require(index < userCards.length, "Index out of bounds");
        
        // We save the card information before removing it (for the event)
        Card memory removedCard = userCards[index];
        
        // We use the removeAt function from the library
        userCards.removeAt(index);
        
        emit CardRemoved(msg.sender, removedCard.id, removedCard.name);
    }

    // Function to view the cards in the collection
    function viewCollection() public view returns (Card[] memory) {
        return collections[msg.sender];
    }

    // Function to check if a card exists
    function checkCardExists(uint256 id) public view returns (bool) {
        return collections[msg.sender].exists(id);
    }
}