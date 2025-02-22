// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./DAOGovernance.sol";

contract DAOToken is ERC20("DAOToken", "DAO") {
    address daoGovernance;

    function initialize(address _daoGovernance, address treasury) external {
        require(daoGovernance == address(0), "Already initialized");
        _mint(treasury, 1000000 * 10 ** 18);
        daoGovernance = _daoGovernance;
    }


    modifier whenNotStopped {
        require(!DAOGovernance(daoGovernance).isStopped(), "Contract is stopped");
        _;
    }


    function transfer(address recipient, uint256 amount) public override whenNotStopped returns (bool) {
        return super.transfer(recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override whenNotStopped returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }
}