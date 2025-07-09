// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
 
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 minimumUSD = 5;
    uint256 public myValue = 1;

    function fund() public payable{
        myValue = myValue +2;
        require(msg.value > 1e18 , "didn't send enough ETH");

        // What is revert?
        // revert is undo any actions that have been done , and send the remaining gas back
    }

    function getPrice() public view returns (uint256){
        // Address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price in ETH in terms USD
        return uint256(price * 1e10);
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    function withdraw() public{

    }
}