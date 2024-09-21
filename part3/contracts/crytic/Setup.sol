// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../uni-v2/UniswapV2Pair.sol";
import "../uni-v2/UniswapV2ERC20.sol";
import "../uni-v2/UniswapV2Factory.sol";
import "../uni-v2/UniswapV2Router01.sol";


contract Users {

    function proxy(address targetContract, bytes memory data) public returns(bool success, bytes memory retData){
        return targetContract.call(data); 
    }
}


contract Setup {

    UniswapV2Pair pairContract;
    UniswapV2ERC20 testToken1;
    UniswapV2ERC20 testToken2;
    // UniswapV2ERC20 testErcContract1;
    // UniswapV2ERC20 testErcContract2;
    UniswapV2Factory factoryContract;
    // UniswapV2Router01 routerContract;

    Users user;
    bool completed;
    // bool mintCompleted;





    constructor() public{
        testErcContract1 = new UniswapV2ERC20();
        testErcContract2 = new UniswapV2ERC20();
        factoryContract = new UniswapV2Factory(address(this));
        factoryContract.createPair(address (testErcContract1), address (testErcContract2));
        // This will be called by fatctory below contract
        pairContract = new UniswapV2Pair();
        // routerContract = new UniswapV2Router01(address(factoryContract), weth address); 

        user = new Users();
    }


    // Helper functions

    // function _mintTokens(uint amount1, uint amount2) internal{
    //     // pairContract.mint()
    //     testErcContract1.mint(address(user), amount1);
    //     testErcContract2.mint(address(user), amount2);
    //     mintCompleted = true;
    // }

    // function _between(uint value, uint low, uint high) internal pure returns(uint) {
    //     return low + (value % (high-low +1)); 
    // }

    function _init(uint amount1, uint amount2) internal {
        testToken1.mint(address(user), amount1);
        testToken2.mint(address(user), amount2);
        completed = true;
    }


    function _between(uint val, uint low, uint high) internal pure returns(uint) {
        return low + (val % (high-low +1)); 
    }
}