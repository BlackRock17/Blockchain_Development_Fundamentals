// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EventTicketNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _toketIds;

    struct TicketMetadata {
        string eventName;
        uint256 eventDate;
        string seatNumber;
        bool isValid;
    }

    mapping(uint256 => TicketMetadata) private _TicketMetadata;
    mapping(address => bool) private _aprrovedTransferers;

    
}