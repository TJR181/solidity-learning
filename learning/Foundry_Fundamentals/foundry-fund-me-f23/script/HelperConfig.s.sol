// SPDX-License-Identifier: MIT

// 1.Deploy mocks when we are on a local anvil chain
// 2.Keep track of contract address across different chains
// Sepolia ETH/USD
// Mainnet ETH/USD

pragma solidity ^0.8.19;

import {Script} from "forge-std/Script.sol";

contract HelperConfig {
    // If we are on a local anvil, we deploy mocks
    // otherwise, grab the existing address from the live network
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }

    constructor() {
        if(block.chainid == 11155111){
            activeNetworkConfig = getSepoliaEthConfig();
        }
        else if(block.chainid == 1) {
            activeNetworkConfig = getMainnetEhConfig();
        }
        else {
            activeNetworkConfig = getAnvilEhConfig();
        }
    }

    function getSepoliaEthConfig() public pure returns(NetworkConfig memory) {
        // price feed address
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getMainnetEhConfig() public pure returns(NetworkConfig memory) {
       // price feed address
        NetworkConfig memory ethConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return ethConfig;
    }

    function getAnvilEhConfig() public pure returns(NetworkConfig memory) {
       // price feed address
    }
}