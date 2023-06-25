// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    function add(uint256 x, uint256 y) public pure returns (uint256) {
        return x + y;
    }

    function subtract(uint256 x, uint256 y) public pure returns (uint256) {
        return x - y;
    }

    function multiply(uint256 x, uint256 y) public pure returns (uint256) {
        return x * y;
    }

    function divide(uint256 x, uint256 y) public pure returns (uint256) {
        require(y != 0, "Cannot divide by zero");
        return x / y;
    }
}
