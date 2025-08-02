// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

// What can we  do to work with address outside our system?
// 1. Unit
//    - Testing a specific part of our code
// 2. Integration
//    - Testing how our code works with other part of code
// 3. Forked
//    - Test our code on a simulated environment
// 4. Stating
//    -

contract FundMeTest is Test {
    FundMe fundMe;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;
    address USER = makeAddr("river");

    function setUp() external {
        DeployFundMe deployFundme = new DeployFundMe();
        fundMe = deployFundme.run();
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public view {
        assertEq(msg.sender, fundMe.i_owner());
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // It means the next line need to revert
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.deal(USER, STARTING_BALANCE);
        vm.prank(USER); // The next TX will be sent by user
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(SEND_VALUE, amountFunded);
    }

    
}
