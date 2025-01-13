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
}