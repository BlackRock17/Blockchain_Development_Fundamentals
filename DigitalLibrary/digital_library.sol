// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract DigitalLibrary {

    enum BookStatus {
        Active,
        Outdated,
        Archived
    }

    struct EBook {
        string title;
        string author;
        uint256 publicationDate;
        uint256 expirationDate;
        BookStatus status;
        address primaryLibrarian;
        uint256 readCount;
    }

    mapping(uint256 => EBook) public ebooks;

    mapping(uint256 => mapping(address => bool)) public authorizedLibrarians;

    uint256 private nextEbookID;

    // Events
    event EBookCreated(uint256 indexed ebookId, string title, address primaryLibrarian);
    event LibrarianAdded(uint256 indexed ebookId, address librarian);
    event ExpirationExtended(uint256 indexed ebookId, uint256 newExpirationDate);
    event StatusChanged(uint256 indexed ebookId, BookStatus newStatus);

}