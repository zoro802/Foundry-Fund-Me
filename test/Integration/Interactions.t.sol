// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../Script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../Script/Interactions.s.sol";

contract InteractionsTest is Test {
    FundMe fundme;
    address user = makeAddr("ziad");
    uint256 constant send_value = 0.1 ether;
    uint256 constant starting_balance = 10 ether;
    uint256 constant Gas_Price = 1;

    function setUp() external {
        DeployFundMe deployfundme = new DeployFundMe();
        fundme = deployfundme.run();
        vm.deal(user, starting_balance);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundfundme = new FundFundMe();
        fundfundme.fundfundMe(address(fundme));

        WithdrawFundMe withdrawfundMe = new WithdrawFundMe();
        withdrawfundMe.withdrawfundme(address(fundme));

        assert(address(fundme).balance == 0);
    }
}
