// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;



import "./Setup.sol";

contract SelfEchidnaTest is Setup {

    // event TokenSuccess(bool success1, bool success2, bool success3);

    // function testProvideLiquidity(uint amount0, uint amount1) public {
    //     // Preconditions:
    //     amount0 = _between(amount0, 1000, uint(-1));
    //     amount1 = _between(amount1, 1000, uint(-1));

    //     if (!completed) {
    //         _init(amount0, amount1);
    //     }
    //     //// State before
    //     uint lpTokenBalanceBefore = pairContract.balanceOf(address(user));
    //     (uint reserve0Before, uint reserve1Before,) = pairContract.getReserves();
    //     uint kBefore = reserve0Before * reserve1Before;
    //     //// Transfer tokens to UniswapV2Pair contract
    //     (bool success1,) = user.proxy(address(testToken1), abi.encodeWithSelector(testToken1.transfer.selector, address(pairContract), amount0));
    //     (bool success2,) = user.proxy(address(testToken2), abi.encodeWithSelector(testToken2.transfer.selector, address(pairContract), amount1));
    //     require(success1 && success2);

    //     // Action:
    //     (bool success3,) = user.proxy(address(pairContract), abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(user)));

    //     // Postconditions:
    //     if (success3) {
    //         uint lpTokenBalanceAfter = pairContract.balanceOf(address(user));
    //         (uint reserve0After, uint reserve1After,) = pairContract.getReserves();
    //         uint kAfter = reserve0After * reserve1After;
    //         assert(lpTokenBalanceBefore < lpTokenBalanceAfter);
    //         assert(kBefore < kAfter);
    //     }
    // }

    function testProvideLiquidity(uint amount1, uint amount2) public {
        // Pre-Conditions
        // type(uint256).max
        // type(uint256).max
        // uint maxVal = uint(-1);
        amount1 = _between(amount1, 1000, uint(-1));
        amount2 = _between(amount2, 1000, uint(-1));


        if(!mintCompleted){
            _mintTokens(amount1, amount2);
        }

        // Intial Balance of lp tokens
        uint256 lpTokenBalInitial = pairContract.balanceOf(address(user));
        (uint reserve1Before, uint reserve2Before,) = pairContract.getReserves();
        // uint256 intialK = pairContract.kLast();
        uint256 intialK = reserve1Before * reserve2Before;


        

        (bool success1,) = user.proxy(address(testErcContract1), abi.encodeWithSelector(testErcContract1.transfer.selector, address(pairContract),amount1));

        (bool success2,) = user.proxy(address(testErcContract2), abi.encodeWithSelector(testErcContract2.transfer.selector, address(pairContract),amount2));

        require(success1 && success2);

        // Actions

        (bool success3,) = user.proxy(address(pairContract), abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(user)));
        // (bool success3,) = user.proxy(address(pairContract), abi.encodeWithSelector(bytes4(keccak256("mint(address)")), address(user)));
        // emit TokenSuccess(success1, success2, success3);
        // if (success3) {
        //     uint lpTokenBalanceAfter = pairContract.balanceOf(address(user));
        //     (uint reserve0After, uint reserve1After,) = pairContract.getReserves();
        //     uint kAfter = reserve0After * reserve1After;
        //     assert(lpTokenBalanceBefore < lpTokenBalanceAfter);
        //     assert(kBefore < kAfter);
        // }
        // Post-Conditions
        if (success3) {
            // uint lpTokenBalAfter = pairContract.balanceOf(address(user));
            // (uint reserve1After, uint reserve2After,) = pairContract.getReserves();
            // // uint256 intialK = pairContract.kLast();
            // uint256 afterK = reserve1After * reserve2After;
            // assert(lpTokenBalAfter > lpTokenBalInitial );
            // // As we have increased the pool by providing tokens
            // // afterK will be equal to intialk in the case we make a swap of the tokens but when we provide liwuidity than it should increase 
            // assert(afterK > intialK);

            uint lpTokenBalanceAfter = pairContract.balanceOf(address(user));
            (uint reserve1After, uint reserve2After,) = pairContract.getReserves();
            uint kAfter = reserve1After * reserve2After;
            assert(lpTokenBalInitial < lpTokenBalanceAfter);
            assert(intialK < kAfter);
        }
    }
}