// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

contract Ownership{

    address owner = msg.sender;

    function Owner() public{
        owner = msg.sender;
    }

    modifier isOwner(){
        require(owner == msg.sender);
        _;
    }
}

contract Pausable is Ownership{

    bool is_paused;

    modifier ifNotPaused(){
        require(!is_paused);
        _;
    }

    function paused() isOwner public{
        is_paused = true;
    }

    function resume() isOwner public{
        is_paused = false;
    }

}

contract Token is Pausable{
    mapping(address => uint) public balances;

    function transfer(address to, uint value) ifNotPaused public{
        // As this is solidity 7 version so this doesn't have the built in safemath checks as 8 version
        // uint256 intialBalanceOfSender = balances[msg.sender];
        // uint256 intialBalanceOfTo = balances[to];
        balances[msg.sender] -= value;
        balances[to] += value;
        // require(intialBalanceOfSender > balances[msg.sender]);
        // require(intialBalanceOfTo < balances[to]);
    }
}
