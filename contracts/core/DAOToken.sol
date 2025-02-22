// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DAOToken is ERC20 {
    constructor(address treasury) ERC20("DAOToken", "DAO") {
        _mint(treasury, 1000000 * 10 ** 18);
    }
}