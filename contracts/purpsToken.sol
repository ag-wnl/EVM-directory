pragma solidity ^0.8.0;

contract purps {
    address Deployer;
    mapping(address => uint) balances; // address, balance key value pairs in a map

    constructor() {
        Deployer = msg.sender;
    }

    function sendTokens(uint Amount, address Receiver) public{
        require(msg.sender == Deployer, "Only deployer of the contract can send tokens."); 
        balances[Receiver] += Amount;
    }

    function viewBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
