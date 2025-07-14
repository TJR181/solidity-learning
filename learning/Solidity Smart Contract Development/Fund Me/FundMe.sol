// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
 
//import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe{
    using PriceConverter for uint256;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;
    uint256 public constant MINIMUM_USD = 5 * 1e18;
    uint256 public myValue = 1;
    address public immutable owner;

    // constructor is a function that was called immediately once we deploy a contract
    constructor(){
        owner = msg.sender;
    }

    function fund() public payable{
        //myValue = myValue +2;
        //require(getConversionRate(msg.value) >= minimumUSD , "didn't send enough ETH");
        require(msg.value.getConversionRate() >= MINIMUM_USD , "didn't send enough ETH");
        // What is revert?
        // revert is undo any actions that have been done , and send the remaining gas back↑
        funders.push(msg.sender);
        //addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
        addressToAmountFunded[msg.sender] += msg.value;
    }


    function withdraw() public onlyOwner{
        //require(msg.sender == owner , "Must be owner!");
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);

        // Three different ways to send native cryptocurrency
        // Transfer
        // Send
        // Call

        // 1.Transfer
        // msg.sender is an address type
        // payable(msg.sender) is a payable address type
        //payable(msg.sender).transfer(address(this).balance);

        // 2.Send
        //bool sendSuccess = payable(msg.sender).send(address(this).balance);
        //require(sendSuccess , "send failed!");

        // 3.Call
        (bool callSuccess , ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess , "call failed!");
    }

    modifier onlyOwner(){
        //require(msg.sender == owner , "Sender is not owner!");
        if(msg.sender != owner){
            revert NotOwner();
        }
        _;
    }
}