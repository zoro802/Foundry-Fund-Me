// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.1 ether;

    function fundfundMe(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeploy)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        fundfundMe(mostRecentlyDeploy);
    }
}

contract WithdrawFundMe is Script {
    function withdrawfundme(address mostRecentlyDeploy) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeploy)).cheaperWithdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeploy = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        withdrawfundme(mostRecentlyDeploy);
    }
}
