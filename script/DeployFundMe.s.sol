// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Script.sol";
import "../src/FundMe.sol";
import "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        HelperConfig helperconfig = new HelperConfig();
        address ethUsdpricefeed = helperconfig.activeNetworkConfig();
        vm.startBroadcast();
        FundMe fundme = new FundMe(ethUsdpricefeed);
        vm.stopBroadcast();
        return fundme;
    }
}
