// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionTest is Test {
        
    FundMe fundMe;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    address USER = makeAddr("river");
    uint256 constant GAS_PRICE = 1;
    
    function setUp() external {
        DeployFundMe deployFundme = new DeployFundMe();
        fundMe = deployFundme.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
        assertEq(address(fundMe).balance, 0);
    }

}