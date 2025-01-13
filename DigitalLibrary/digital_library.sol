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

    function extendExpirationDate(uint256 _ebookId, uint256 _daysToExtend) external {

         require(ebooks[_ebookId].primaryLibrarian != address(0), "Book does not exist");

         require(
            isAuthorizedLibrarian(_ebookId, msg.sender),
            "Only authorized librarian can extend expiration"
        );

        require(_daysToExtend <= 365, "Cannot extend for more than 365 days");

        uint256 newExpirationDate = ebooks[_ebookId].expirationDate + (_daysToExtend * 1 days);

        ebooks[_ebookId].expirationDate = newExpirationDate;

        if (ebooks[_ebookId].status == BookStatus.Outdated) {
            ebooks[_ebookId].status = BookStatus.Active;
        }

        emit ExpirationExtended(_ebookId, newExpirationDate);
    }

    function changeStatus(uint256 _ebookId, BookStatus _newStatus) external {
        
        require(ebooks[_ebookId].primaryLibrarian != address(0), "Book does not exist");

        require(
            msg.sender == ebooks[_ebookId].primaryLibrarian,
            "Only primiry librarian can change status"
        );

        if (_newStatus == BookStatus.Active) {
            require(
                ebooks[_ebookId].expirationDate > block.timestamp,
                "Cannot set to Active if expiration date is passed"
                );
        }

        ebooks[_ebookId].status = _newStatus;

        emit StatusChanged(_ebookId, _newStatus);
    }

    function checkExpiration(uint256 _ebookId) external returns (bool isExpired) {

        require(ebooks[_ebookId].primaryLibrarian != address(0), "Book does not exist");

        ebooks[_ebookId].readCount++;

        require(
            ebooks[_ebookId].status != BookStatus.Archived,
            "Book is archived"
        );

        bool expired = block.timestamp > ebooks[_ebookId].expirationDate;

        if (expired && ebooks[_ebookId].status == BookStatus.Active) {
            ebooks[_ebookId].status = BookStatus.Outdated;
            emit StatusChanged(_ebookId, BookStatus.Outdated);
        }

        return expired;
    }

}