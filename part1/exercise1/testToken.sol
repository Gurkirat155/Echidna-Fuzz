// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;

import "./token.sol";

contract TestToken is Token {
    
    address echidna_caller = msg.sender;

    constructor () {
        balances[echidna_caller] = 10000;
    }

    function echidna_test_balances() public view returns(bool){
        return balances[echidna_caller] <= 10000;
    }
}