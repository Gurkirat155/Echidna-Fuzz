// SPDX-License-Identifier: MIT
pragma solidity ^0.7.0;
import "./token.sol";

/// @dev to run: $ echidna-test solution.sol
contract TestToken is Token {
    address echidna_caller = msg.sender;

    constructor() {
        balances[echidna_caller] = 10000;
    }

    // add the property
    function echidna_test_balance() public view returns (bool) {
        return balances[echidna_caller] <= 10000;
    }
}
