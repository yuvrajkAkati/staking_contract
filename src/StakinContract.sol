// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakingContract{
    
    mapping(address => uint256) public balances;
    uint totalSupply = 0;

    constructor(){

    }

    function stake(uint _amount) external payable  {
        require(_amount == msg.value);
        totalSupply = totalSupply + _amount;
        payable(msg.sender).transfer();
    }
    function unstake(uint _amount) external {

    }

}