// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/Coin.sol";

contract CoinTest is Test {
    Coin coin;

    function setUp() public {
        coin = new Coin(address(this));
    }

    function testInitialSupply () public view {
        assert(coin.totalSupply() == 0);
    }

    function test_Revert_Minting() public {
        vm.expectRevert();
        vm.startPrank(0xA4e99114eF4c26Ea93C6fB4678a4172941951706);
        coin.mint(0xA4e99114eF4c26Ea93C6fB4678a4172941951706,100);
    }
    function testMint()public {
        coin.mint(0xA4e99114eF4c26Ea93C6fB4678a4172941951706,100);
        assert(coin.balanceOf(0xA4e99114eF4c26Ea93C6fB4678a4172941951706) == 100);
    }
    function testChangeStakingContract() public {
        coin.updateStakingContract(0xA4e99114eF4c26Ea93C6fB4678a4172941951706);
        vm.startPrank(0xA4e99114eF4c26Ea93C6fB4678a4172941951706);
        coin.mint(0xA4e99114eF4c26Ea93C6fB4678a4172941951706,100);
        assert(coin.balanceOf(0xA4e99114eF4c26Ea93C6fB4678a4172941951706) == 100);
    }

}
