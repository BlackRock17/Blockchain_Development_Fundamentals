// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract Asset {
    string public symbol;
    string public name;
    uint256 public totalSupply;
    mapping(address => uint256) public balances;

    constructor(
        string memory _symbol,
        string memory _name,
        uint256 _initialSuplly
    ) {
        symbol = _symbol;
        name = _name;
        totalSupply = _initialSuplly;
        balances[msg.sender] = _initialSuplly;
    }

    function transfer(address _to, uint256 _amount) external returns (bool) {
        require(balances[msg.sender] >= _amount, "Insuffisient balance");
        require(_to != address(0), "Invalid recipient address");

        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        return true;
    }

}