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

    function testPriceFeedVersionIsAccurate() public view {
        uint256 version = fundMe.getVersion();
        assertEq(version,6);
    }
    
}
