// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract purpsTokenContract {
    string public name = "Purps";
    string public symbol = "PURP";
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000000 * (10 ** uint256(decimals));

    address Deployer;
    mapping(address => uint256) public balanceOf; 
    mapping(address => mapping(address => uint256)) public allowance; // enable 3rd party transacions

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    constructor() {
        Deployer = msg.sender;
        balanceOf[Deployer] = totalSupply;
        emit Transfer(address(0), Deployer, totalSupply);
    }

    function transfer(address receiver, uint256 amount) public returns (bool success) {
        require(balanceOf[msg.sender] >= amount, "Not enough balance.");
        require(receiver != address(0), "Invalid address.");
        balanceOf[msg.sender] -= amount;
        balanceOf[receiver] += amount;
        emit Transfer(msg.sender, receiver, amount);
        return true;
    }

    function approve(address spender, uint256 amount) public returns (bool success) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 amount) public returns (bool success) {
        require(balanceOf[_from] >= amount, "Not enough balance.");
        require(allowance[_from][msg.sender] >= amount, "Allowance exceeded, not permitted transaction.");

        balanceOf[_from] -= amount;
        balanceOf[_to] += amount;
        emit Transfer(_from, _to, amount);
        return true;
    }

    function _burn(address _from, uint256 amount) public returns (bool success) {
        require(balanceOf[_from] >= amount, "Not enough balance");
        
        balanceOf[_from] -= amount;
        totalSupply -= amount;
        emit Transfer(_from, address(0), amount);
        return true;
    }
}
