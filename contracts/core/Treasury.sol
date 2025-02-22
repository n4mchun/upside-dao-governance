// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./DAOGovernance.sol";

contract Treasury {
    address governance;
    IERC20 daoToken;


    /**
     * @dev Emitted when funds are deposited into the contract.
     * @param from The address from which the funds are deposited.
     * @param amount The amount of funds deposited.
     */
    event FundsDeposited(address indexed from, uint256 amount);

    /**
     * @dev Emitted when ETH is withdrawn from the contract.
     * @param to The address to which the ETH is withdrawn.
     * @param amount The amount of ETH withdrawn.
     */
    event FundsWithdrawn(address indexed to, uint256 amount);

    /**
     * @dev Emitted when tokens are withdrawn from the contract.
     * @param to The address to which the tokens are withdrawn.
     * @param amount The amount of tokens withdrawn.
     */
    event TokenWithdrawn(address indexed to, uint256 amount);


    /**
     * @dev Modifier to make a function callable only by the governance.
     */
    modifier onlyGovernance {
        require(msg.sender == governance, "Only governance allowed");
        _;
    }

    /**
     * @dev Modifier to make a function callable only when the contract is not stopped.
     * @notice This contract relies on the value of DAOGovernance.
     */
    modifier whenNotStopped {
        require(!DAOGovernance(governance).isStopped(), "Contract is stopped");
        _;
    }


    /**
     * @dev Constructor.
     * @param _daoToken The address of the DAO token.
     */
    constructor(address _daoToken) {
        daoToken = IERC20(_daoToken);
    }

    /**
     * @dev Initializes the governance address.
     * @param _governance The address of the governance contract.
     */
    function setGovernance(address _governance) external {
        require(governance == address(0), "Already initialized");
        governance = _governance;
    }

    /**
     * @dev Withdraws ETH from the contract. (DAO vote approval required)
     * @param to The address to withdraw the ETH to.
     * @param amount The amount of ETH to withdraw.
     *
     * Requirements:
     * - The contract must have sufficient ETH.
     */
    function withdrawETH(address to, uint256 amount) external onlyGovernance whenNotStopped {
        require(address(this).balance >= amount, "Insufficient ETH");
        payable(to).transfer(amount);
        emit FundsWithdrawn(to, amount);
    }

    /**
     * @dev Withdraws tokens from the contract. (DAO vote approval required)
     * @param to The address to withdraw the tokens to.
     * @param amount The amount of tokens to withdraw.
     *
     * Requirements:
     * - The contract must have sufficient tokens.
     */
    function withdrawToken(address to, uint256 amount) external onlyGovernance whenNotStopped {
        require(daoToken.balanceOf(address(this)) >= amount, "Insufficient tokens");
        daoToken.transfer(to, amount);
        emit TokenWithdrawn(to, amount);
    }


    /**
     * @dev Returns the balance of the contract.
     * @return The balance of the contract in ETH.
     */
    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    /**
     * @dev Returns the token balance of the contract.
     * @return The balance of the contract in DAO tokens.
     */
    function getTokenBalance() external view returns (uint256) {
        return daoToken.balanceOf(address(this));
    }


    /**
     * @dev Fallback function to receive ETH.
     */
    receive() external payable {
        emit FundsDeposited(msg.sender, msg.value);
    }
}