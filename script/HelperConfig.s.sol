// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";

contract HelperConfig is Script {
// Deploy mocks when on a local anvil chain
// Otherwise, grab the existing address from the live network

    // If we are on a local anvil chain, we deploy mocks

    NetworkConfig public activeNetworkConfig;
    struct NetworkConfig {
        address priceFeed; // ETH/USD price feed address
    }
    

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        });
        return sepoliaConfig;
    }

    function getAnvilEthConfig() public pure {

    }
}
