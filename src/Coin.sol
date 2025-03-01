// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface ICOIN is IERC20 {
    function approve(address spender , uint amount)external returns (bool);
    function allowance(address owner , address spender )external view returns (uint amount);
    function transfer(address sender , address recipient, uint amount ) external returns(bool);
    function balanceOf(address account ) external view returns (uint256);
}

contract Coin is ERC20 {
    address public stakingContract;
    address owner;
    constructor(address _stakingContract) ERC20("Coin", "COIN"){
        stakingContract = _stakingContract;
        owner = msg.sender;
    }

    function mint(address to, uint256 amount) public  {
        require(msg.sender == stakingContract);
        _mint(to, amount);
    }

    function updateStakingContract (address _stakingContract) public {
        require(msg.sender == owner);
        stakingContract = _stakingContract;
    }

}
