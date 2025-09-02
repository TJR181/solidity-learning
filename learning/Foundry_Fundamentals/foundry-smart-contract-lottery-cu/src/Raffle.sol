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

import {VRFConsumerBaseV2Plus} from "@chainlink/contracts/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
import {VRFV2PlusClient} from "@chainlink/contracts/src/v0.8/vrf/dev/libraries/VRFV2PlusClient.sol";

/**
 * @title A sample Raffle contract
 * @author R1ver
 * @notice This contract is just for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */
contract Riffle is VRFConsumerBaseV2Plus {
    /* Errors */
    error Raffle__ETHAmountError();
    error Raffle__ShouldExceedInternal();
    error Raffle__TransferFailed();

    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private immutable CALLBACK_GAS_LIMIT;
    uint32 private constant NUM_WORDS = 1;
    uint256 private immutable I_ENTRANCEFEE;
    uint256 private immutable I_INTERVAL;
    uint256 private immutable I_SUBSCRIPTIONID;
    bytes32 private immutable I_KEYHASH;
    uint256 private lastTimeStamp;
    address payable[] private players;
    address private recentWinner;

    /* Events */
    event RaffleEntered(address indexed player);

    constructor(
        uint256 _entranceFee,
        uint256 _interval,
        address _vrfCoordinator,
        bytes32 _gasLane,
        uint256 _subscriptionId,
        uint32 _callbackGasLimit
    ) VRFConsumerBaseV2Plus(_vrfCoordinator) {
        I_ENTRANCEFEE = _entranceFee;
        I_INTERVAL = _interval;
        I_SUBSCRIPTIONID = _subscriptionId;
        I_KEYHASH = _gasLane;
        CALLBACK_GAS_LIMIT = _callbackGasLimit;
        lastTimeStamp = block.timestamp;
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

    // 1. Get a random nummber
    // 2. Use random number to pick a player
    // 3. Be automatically called
    function pickWinner() external {
        // check to see if enough time has passed
        if (block.timestamp - lastTimeStamp < I_INTERVAL) {
            revert Raffle__ShouldExceedInternal();
        }
        // Get random number by chainlink v2.5
        // 1. request RNG
        // 2. Get RNG
        VRFV2PlusClient.RandomWordsRequest memory requests = VRFV2PlusClient.RandomWordsRequest({
            keyHash: I_KEYHASH,
            subId: I_SUBSCRIPTIONID,
            requestConfirmations: REQUEST_CONFIRMATIONS,
            callbackGasLimit: CALLBACK_GAS_LIMIT,
            numWords: NUM_WORDS,
            extraArgs: VRFV2PlusClient._argsToBytes(
                // Set nativePayment to true to pay for VRF requests with Sepolia ETH instead of LINK
                VRFV2PlusClient.ExtraArgsV1({nativePayment: false})
            )
        });
        uint256 requestId = s_vrfCoordinator.requestRandomWords(requests);
    }

    function fulfillRandomWords(uint256 requestId, uint256[] calldata randomWords) internal override {
        uint256 indexOfWinner = randomWords[0] % players.length;
        recentWinner = players[indexOfWinner];
        (bool success,) = recentWinner.call{value: address(this).balance}("");
        if(!success) {
            revert Raffle__TransferFailed();
        }
    }

    /**
     * Getter Functions
     */
    function getEntranceFee() public view returns (uint256) {
        return I_ENTRANCEFEE;
    }
}
