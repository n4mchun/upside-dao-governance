// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/Script.sol";

contract Deploy is Script {
    function setUp() external {}
    
    function run() external {
        vm.startBroadcast();

        // ...

        vm.stopBroadcast();
    }
}