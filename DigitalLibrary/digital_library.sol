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

    function createEbook(
        string calldata _title,
        string calldata _author,
        uint256 _publicationDate
    ) external returns (uint256) {

        uint256 newEbookID = nextEbookID;
        
        uint256 expirationDate = block.timestamp + 180 days;

        ebooks[newEbookID] = EBook({
            title: _title,
            author: _author,
            publicationDate: _publicationDate,
            expirationDate: expirationDate,
            status: BookStatus.Active,
            primaryLibrarian: msg.sender,
            readCount: 0
        });

        authorizedLibrarians[newEbookID][msg.sender] = true;

        nextEbookID++;

        emit EBookCreated(newEbookID, _title, msg.sender);

        return newEbookID;
    }

    function addLibrariran(uint256 _ebookID, address _librarian) external {

        require(ebooks[_ebookID].primaryLibrarian != address(0), "Book does not exist");

        require(msg.sender == ebooks[_ebookID].primaryLibrarian, "Only primary librarian can add new librarians");

        require(_librarian != address(0), "Invalid librarian address");

        require(!authorizedLibrarians[_ebookID][_librarian], "Librarian already authorized");

        authorizedLibrarians[_ebookID][_librarian] = true;

        emit LibrarianAdded(_ebookID, _librarian);
    }

    function isAuthorizedLibrarian(uint256 _ebookID, address _librarian) public view returns (bool) {
        return authorizedLibrarians[_ebookID][_librarian];
    }

}