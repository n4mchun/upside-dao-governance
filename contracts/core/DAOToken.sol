// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./DAOGovernance.sol";

contract DAOToken is ERC20("DAOToken", "DAO") {
    address daoGovernance;

    /**
     * @dev Constructor.
     * @notice This contract is initialized by the DAO.
     */
    function initialize(address _daoGovernance, address treasury) external {
        require(daoGovernance == address(0), "Already initialized");
        _mint(treasury, 1000000 * 10 ** 18);
        daoGovernance = _daoGovernance;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not stopped.
     * @notice This contract relies on the value of DAOGovernance.
     */
    modifier whenNotStopped {
        require(!DAOGovernance(daoGovernance).isStopped(), "Contract is stopped");
        _;
    }


    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     * @param recipient The recipient address.
     * @param amount The amount of tokens to send.
     */
    function transfer(address recipient, uint256 amount) public override whenNotStopped returns (bool) {
        return super.transfer(recipient, amount);
    }

    /**
     * @dev See {ERC20-_beforeTokenTransfer}.
     * @param sender The sender address.
     * @param recipient The recipient address.
     * @param amount The amount of tokens to send.
     */
    function transferFrom(address sender, address recipient, uint256 amount) public override whenNotStopped returns (bool) {
        return super.transferFrom(sender, recipient, amount);
    }
}