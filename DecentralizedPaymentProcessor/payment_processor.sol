// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

contract PaymentProcessor {

    mapping(address => uint256) public balances;

    event PaymentReceived(address indexed customer, uint256 amount);
    event RefundProcessed(address indexed customer, uint256 amount);

    function receivePayment() public payable {

        require(msg.value > 0, "Payment amount must be greater than 0");
        balances[msg.sender] += msg.value;
        emit PaymentReceived(msg.sender, msg.value);
    }

    function checkBalance() public view returns (uint256) {

        return balances[msg.sender];
    }

    function refundPayment(uint256 amount) public virtual {

        require(balances[msg.sender] >= amount, "Insufficient balance");
        require(amount > 0, "Refund amount must be greater than 0");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit RefundProcessed(msg.sender, amount);
    }
}