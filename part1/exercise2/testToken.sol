// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";

contract TestToken2 is Token {

    address echidna_address  = msg.sender;

    constructor () {
        paused();
        owner = address(0);
    }

    // Contract is paused and the their is no owner of the contract
    // Property Testing
    function echidna_test_pausable() public view returns(bool){
        return is_paused;
    }

    // Why echidna is special as it can call the functin in sequence and do stateful testing 

    // Assertion testing

    function testPausable() public view {
        assert(is_paused);
    }
}