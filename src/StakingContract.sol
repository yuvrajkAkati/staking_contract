// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StakingContract{
    
    mapping(address => uint256) public balances;
    uint totalSupply = 0;

    mapping (address => uint) public unclaimedRewards;
    mapping (address => uint) public lastUpdatedTime;

    constructor(){

    }

    function stake() external payable  {
        require( msg.value > 0);
        if (lastUpdatedTime[msg.sender] == 0) {
            lastUpdatedTime[msg.sender] = block.timestamp;
        } else {
            unclaimedRewards[msg.sender] += (block.timestamp - lastUpdatedTime[msg.sender]) * balances[msg.sender] * 20;
            lastUpdatedTime[msg.sender] = block.timestamp;
        }
        totalSupply = totalSupply + msg.value;
        balances[msg.sender] = balances[msg.sender] + msg.value; 
    }
    function unstake(uint _amount) external payable {
        require(_amount <= balances[msg.sender],"eth amount is more than your stake amount");

        unclaimedRewards[msg.sender] += (block.timestamp - lastUpdatedTime[msg.sender]) * balances[msg.sender];
        lastUpdatedTime[msg.sender] = block.timestamp;

        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount); 
        totalSupply -= _amount;
    }
    function getRewards(address _address) public view  returns (uint){
        uint currentReward = unclaimedRewards[_address];
        uint newReward = (block.timestamp - lastUpdatedTime[_address] ) * balances[_address] ; 
        return newReward+ currentReward;
    }
    function claimRewards(address _address) public {
        uint currentReward = unclaimedRewards[_address];
        uint newReward = (block.timestamp - lastUpdatedTime[_address] ) * balances[_address] ; 
        unclaimedRewards[msg.sender] = currentReward+newReward;
        //transfer the unclaimedRewards to the msg.sender amd set
        unclaimedRewards[msg.sender] = 0;
        lastUpdatedTime[msg.sender] = block.timestamp;
    }
    function balanceOf(address _address) public view returns(uint256) {
        return balances[_address]; 
    }
}