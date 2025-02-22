// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "../utils/EmergencyStop.sol";
import "../utils/Multicall.sol";

contract DAOGovernance is EmergencyStop, Multicall {
    mapping(uint256 => uint256) public proposals;

    function propose() external {}
    function vote(uint256 proposalId) external {}
    function execute(uint256 proposalId) external {}
}