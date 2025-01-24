// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract EventTicketNFT is ERC721, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    struct TicketMetadata {
        string eventName;
        uint256 eventDate;
        string seatNumber;
        bool isValid;
    }

    mapping(uint256 => TicketMetadata) private _ticketMetadata;
    mapping(address => bool) private _aprrovedTransferers;

    event TicketMinted(address indexed to, uint256 indexed tokenId, string eventName, string seatNumber);
    event TicketTransferred(address indexed from, address indexed to, uint256 indexed tokenId);
    event TransfererStatusUpdated(address indexed transferer, bool status);

    constructor() ERC721("EventTicketNFT", "ETN") Ownable(msg.sender) {}

    function mintTicket(
        address to,
        string memory eventName,
        uint256 eventDate,
        string memory seatNumber
    ) public onlyOwner returns (uint256) {
        _tokenIds.increment();
        uint256 newTokenId = _tokenIds.current();

        _safeMint(to, newTokenId);
        _ticketMetadata[newTokenId] = TicketMetadata(
            eventName,
            eventDate,
            seatNumber,
            true
        );

        emit TicketMinted(to, newTokenId, eventName, seatNumber);
        return newTokenId;
    }
}