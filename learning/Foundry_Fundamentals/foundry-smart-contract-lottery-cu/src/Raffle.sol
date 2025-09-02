// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title A sample Raffle contract
 * @author R1ver
 * @notice This contract is just for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */

contract Riffle {
    /* Errors */
    error Raffle__ETHAmountError();

    uint256 private immutable I_ENTRANCEFEE;
    address payable[] private players;

    /* Events */
    event RaffleEntered (
        address indexed player
    );

    constructor(uint256 _entranceFee) {
        I_ENTRANCEFEE = _entranceFee;
    }

    function enterRaffle() public payable {
        // require(msg.value == I_ENTRANCEFEE, "Not enough ETH sent!");
        // require(msg.value == I_ENTRANCEFEE, ETHAmountError());
        if (msg.value != I_ENTRANCEFEE) {
            revert Raffle__ETHAmountError();
        }
        players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {}

    /** 
     * Getter Functions 
     */
    function getEntranceFee() public view returns(uint256) {
        return I_ENTRANCEFEE;
    }
}