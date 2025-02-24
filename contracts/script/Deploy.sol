// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "../core/DAOGovernance.sol";
import "../core/Treasury.sol";
import "../core/DAOToken.sol";
import "../proxy/DAOProxy.sol";
import "forge-std/Script.sol";

contract Deploy is Script {
    function setUp() external {}
    
    function run() external {
        vm.startBroadcast();

        DAOToken daoToken = new DAOToken();
        Treasury treasury = new Treasury(address(daoToken));
        DAOGovernance daoGovernance = new DAOGovernance();
        
        // data is empty yet
        DAOProxy proxy = new DAOProxy(address(daoGovernance), bytes(""));
        

        daoToken.initialize(address(daoGovernance), address(treasury));
        treasury.setGovernance(address(daoGovernance));

        console.log("DAOGovernance:", address(daoGovernance));
        console.log("DAOToken:     ", address(daoToken));
        console.log("Treasury:     ", address(treasury));
        console.log("DAOProxy:     ", address(proxy));

        vm.stopBroadcast();
    }
}