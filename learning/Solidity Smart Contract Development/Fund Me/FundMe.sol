// Get funds from users
// Withdraw Funds 
// Set a minimum funding value in USD

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface AggregatorV3Interface {
  function decimals() external view returns (uint8);

  function description() external view returns (string memory);

  function version() external view returns (uint256);

  function getRoundData(
    uint80 _roundId
  ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

  function latestRoundData()
    external
    view
    returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract FundMe{

    uint256 minimumUSD = 5;
    uint256 public myValue = 1;

    function fund() public payable{
        myValue = myValue +2;
        require(msg.value > 1e18 , "didn't send enough ETH");

        // What is revert?
        // revert is undo any actions that have been done , and send the remaining gas back
    }

    function getPrice() public{
        // Address = 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        
    }

    function getVersion() public view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    function withdraw() public{

    }
}