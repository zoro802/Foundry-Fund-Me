// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(AggregatorV3Interface pricefeed) internal view returns (uint256) {
        (, int256 price,,,) = pricefeed.latestRoundData();
        // ETH/USD rate in 18 digit
        return uint256(price * 10000000000);
    }

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface pricefeed) internal view returns (uint256) {
        uint256 ethPrice = getPrice(pricefeed);
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountInUsd;
    }
}
