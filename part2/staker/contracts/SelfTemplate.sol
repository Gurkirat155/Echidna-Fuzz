// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import "./Staker.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

    function mint(address _to, uint256 _amount) external {
        _mint(_to, _amount);
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        address spender = msg.sender;
        //_spendAllowance(from, spender, amount); // allowance was disabled
        _transfer(from, to, amount);
        return true;
    }
}

contract SelfTemplate {

    // We have to setup stake 
        // we need amock erc20 to pass as an address in the constructor for staker
    // Then we can run the tests

    Staker staker;
    MockERC20 tokenAddress;

    constructor() {
        tokenAddress = new MockERC20("Guri", "Gk");
        staker = new Staker(address(tokenAddress));
        tokenAddress.mint(address(this), type(uint128).max);
        // tokenAddress.allowance(address(this), address(staker));
        
    }


    function testStake(uint amount) public {
        // Pre-condition
        // require(amount > 0, "Amount should be greater than 0");
        // require(amount <= type(uint128).max);
        require(tokenAddress.balanceOf(address(this)) > 0);
        uint256 intialTokensBal = tokenAddress.balanceOf(address(this));

        uint256 beforeStakeContractBal = staker.stakedBalances(address(this));
        // Action
        // emit Debug(amount);
        try staker.stake(amount) returns (uint256 stakedAmount) {
            uint256 afterTransferBal = tokenAddress.balanceOf(address(this));
            uint256 afterStakeContractBal = staker.stakedBalances(address(this));

            // Post-condition
            // as exhange is 1:1
            assert(staker.stakedBalances(address(this)) == beforeStakeContractBal + stakedAmount);
            assert(afterTransferBal == intialTokensBal - amount);
        } catch (bytes memory err) {
            assert(false);
        }
        // uint256 stakedAmount = staker.stake(amount);
        // // emit Debug(stakedAmount);

        // uint256 afterTransferBal = tokenAddress.balanceOf(address(this));
        // uint256 afterStakeContractBal = staker.stakedBalances(address(this));

        // // Post-condition
        // // as exhange is 1:1
        // assert(staker.stakedBalances(address(this)) == beforeStakeContractBal + stakedAmount);
        // assert(afterTransferBal == intialTokensBal - amount);

        // First the user should have mint the amount



    }

    function testMintTokens(address _to, uint256 _amount) public {
        tokenAddress.mint(_to, _amount);
    }
// Not working yet 
    function testUnstake(uint256 _stakedAmount) public {
        // Pre-condition
        require(staker.stakedBalances(address(this)) > 0);
        // Optimization: amount is now bounded between [1, stakedBalance[address(this)]]
        uint256 stakedAmount = 1 + (_stakedAmount % (staker.stakedBalances(address(this))));
        // State before the "action"
        uint256 preTokenBalance = tokenAddress.balanceOf(address(this));
        // Action
        uint256 amount = staker.unstake(stakedAmount);
        // Post-condition
        assert(tokenAddress.balanceOf(address(this)) == preTokenBalance + amount); 
    }

}
