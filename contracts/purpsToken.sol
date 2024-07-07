// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract purpsTokenContract {
    string public name = "Purps";
    string public symbol = "PURP";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));

    address Deployer;
    mapping(address => uint256) public balances; 
    mapping(address => mapping(address => uint256)) public allowance; // enable 3rd party transacions

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        Deployer = msg.sender;
        balances[Deployer] = totalSupply;
    }

    function transferTokens(address receiver, uint256 amount) public returns (bool success) {
        require(balances[msg.sender] >= amount, "Not enough balance.");

        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function viewBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function approveTransaction(address spender, uint256 amount) public returns (bool success) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferToAndFrom(address _from, address _to, uint256 amount) public returns (bool success) {
        require(balances[_from] >= amount, "Not enough balance.");
        require(allowance[_from][msg.sender] >= amount, "Allowance exceeded, not permitted transaction.");

        balances[_from] -= amount;
        balances[_to] += amount;
        emit Transfer(_from, _to, amount);
        return true;
    }
}
