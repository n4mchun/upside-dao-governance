// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

contract EmergencyStop {
    bool isStopped = false;
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

    function emergencyStop() public onlyOwner {
        isStopped = true;
    }

    function resume() public onlyOwner {
        isStopped = false;
    }
}