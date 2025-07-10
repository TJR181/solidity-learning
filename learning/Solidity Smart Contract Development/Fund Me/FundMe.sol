// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
 
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    uint256 minimumUSD = 5 * 1e18;
    uint256 public myValue = 1;

    function fund() public payable{
        //myValue = myValue +2;
        require(getConversionRate(msg.value) >= minimumUSD , "didn't send enough ETH");

        // What is revert?
        // revert is undo any actions that have been done , and send the remaining gas back↑
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns (uint256){
        // Address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price in ETH in terms USD
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmouht) public view returns (uint256){
        uint256 usdAmount = ethAmouht * getPrice() / 1e18;
        return usdAmount;
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    function withdraw() public{

    }
}