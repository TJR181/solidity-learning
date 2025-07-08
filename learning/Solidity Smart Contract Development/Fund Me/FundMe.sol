// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FundMe{

    uint256 minimumUSD = 5;
    uint256 public myValue = 1;

    function fund() public payable{
        myValue = myValue +2;
        require(msg.value > 1e18 , "didn't send enough ETH");

        // What is revert?
        // revert is undo any actions that have been done , and send the remaining gas back
    }

    function withdraw() public{

    }
}