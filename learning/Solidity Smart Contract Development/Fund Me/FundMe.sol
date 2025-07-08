// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract FundMe{
    function fund() public payable{
        require(msg.value > 1e18 , "didn't send enough ETH");
    }

    function withdraw() public{

    }
}