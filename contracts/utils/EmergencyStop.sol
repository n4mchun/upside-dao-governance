// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EmergencyStop {
    bool public isStopped = false;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier whenNotStopped {
        require(!isStopped, "Contract Stopped");
        _;
    }

    function emergencyStop() external onlyOwner {
        isStopped = true;
    }

    function resume() external onlyOwner {
        isStopped = false;
    }
}