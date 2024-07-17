// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "../interfaces/ICurve.sol";

contract QuadraticCurve is ICurve {
  function getPrice(uint256 supply, uint32 amount, uint256[] calldata args) external pure returns (uint256) {
    return sum(supply + amount, args) - sum(supply, args);
  }

  /**
   * sum of f(x)= a*x*x + b
   * @param x supply
   */
  function sum(uint256 x, uint256[] memory args) public pure returns (uint256) {
    uint256 len = args.length;
    uint256 a = len > 0 ? args[0] : 1;
    uint256 b = len > 1 ? args[1] : 0;

    uint256 sumOfSquares = (x * (x + 1) * (2 * x + 1) * 1 ether) / 6;
    uint256 sumOfConstants = x * 1 ether;
    uint256 totalSum = a * sumOfSquares + b * sumOfConstants;

    return totalSum;
  }

  function curve(uint256 x, uint256[] memory args) public pure returns (uint256) {
    uint256 len = args.length;
    uint256 a = len > 0 ? args[0] : 1;
    uint256 b = len > 1 ? args[1] : 0;
    return a * x * x + b;
  }
}
