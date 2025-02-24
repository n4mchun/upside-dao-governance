// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../core/DAOGovernance.sol";

contract DAOGovernanceTest is Test {
    DAOGovernance public daoGovernance;

    function setUp() public {
        daoGovernance = new DAOGovernance();
    }
}