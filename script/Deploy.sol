// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "../contracts/core/DAOGovernance.sol";
import "../contracts/core/Treasury.sol";
import "../contracts/core/DAOToken.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
    function setUp() external {}
    
    function run() external {
        vm.startBroadcast();

        DAOToken daoToken = new DAOToken();
        Treasury treasury = new Treasury(address(daoToken));
        DAOGovernance daoGovernance = new DAOGovernance();

        daoToken.initialize(address(daoGovernance), address(treasury));
        treasury.setGovernance(address(daoGovernance));

        console.log("DAOGovernance:", address(daoGovernance));
        console.log("DAOToken:", address(daoToken));
        console.log("Treasury:", address(treasury));

        vm.stopBroadcast();
    }
}