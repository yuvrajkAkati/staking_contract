// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakingContract{
    
    mapping(address => uint256) public balances;
    uint totalSupply = 0;

    constructor(){

    }

    function stake() external payable  {
        require( msg.value > 0);
        totalSupply = totalSupply + msg.value;
        balances[msg.sender] = balances[msg.sender] + msg.value; 
    }
    function unstake(uint _amount) external payable {
        require(_amount <= balances[msg.sender],"eth amount is more than your stake amount");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount); 
        totalSupply -= _amount;
    }
    function getRewards() public  {

    }
    function claimRewards() public view {
        
    }
    function balanceOf(address _address) public view returns(uint256) {
        return balances[_address]; 
    }
}