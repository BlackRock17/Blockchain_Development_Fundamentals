// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract messageBoard {
    mapping(address => string) public messages;

    function storeMessage(string memory _message) public {
        messages[msg.sender] = _message;
    }

    function previewMessage(string memory _message) public pure returns (string memory) {
        return string(abi.encodePacked("Draft: ", _message));
    }
}