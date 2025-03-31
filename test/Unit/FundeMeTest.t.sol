// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../../src/FundMe.sol";
import "../../Script/DeployFundMe.s.sol";

contract FundMeTest is Test {
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

    function testMinimum() public view {
        assertEq(fundme.MINIMUM_USD(), 5e18);
    }

    function testIsOwner() public view {
        // assertEq(fundme.getOwner(), address(this));
        assertEq(fundme.getOwner(), msg.sender);
    }

    function testVersion() public view {
        uint256 version = fundme.getVersion();
        assertEq(version, 4);
    }

    function testFundEnoughEth() public {
        vm.expectRevert();
        fundme.fund();
    }

    function testFundUpdate() public {
        vm.prank(user);
        fundme.fund{value: send_value}();
        uint256 amountfunded = fundme.getAddressToAmountFunded(user);
        assertEq(amountfunded, send_value);
    }

    function testAddFunder() public {
        vm.prank(user);
        fundme.fund{value: send_value}();

        address funder = fundme.getFunder(0);
        assertEq(funder, user);
    }

    modifier funded() {
        vm.prank(user);
        fundme.fund{value: send_value}();
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.prank(user);
        vm.expectRevert();
        fundme.cheaperWithdraw();
    }

    function testWithdrawWithSingleFunder() public funded {
        uint256 staringOwnerBalance = fundme.getOwner().balance;
        uint256 staringFuneMeBalance = address(fundme).balance;

        // uint GasStart = gasleft();
        // vm.txGasPrice(Gas_Price);
        vm.prank(fundme.getOwner());
        fundme.cheaperWithdraw();
        /* uint GasEnd = gasleft();
        uint GasUsed = (GasStart - GasEnd) * tx.gasprice ;
        console.log("GasUsed: ", GasUsed); */

        uint256 endingOwnerBalance = fundme.getOwner().balance;
        uint256 endingFuneMeBalance = address(fundme).balance;

        assertEq(endingFuneMeBalance, 0);
        assertEq(staringFuneMeBalance + staringOwnerBalance, endingOwnerBalance);
    }

    /* function testWithdrawFromMultipleFunders() public funded {
        uint160 numberofFunders = 10;
        uint160 startingFunder = 1;
        for (uint160 i = startingFunder; i < numberofFunders; i++) {
            hoax(address(i), send_value);
            fundme.fund{value: send_value}();
        }
        uint256 staringOwnerBalance = fundme.getOwner().balance;
        uint256 staringFuneMeBalance = address(fundme).balance;

        vm.startPrank(fundme.getOwner());
        fundme.withdraw();
        vm.stopPrank();

        assertEq(address(fundme).balance, 0);
        assertEq(staringFuneMeBalance + staringOwnerBalance, fundme.getOwner().balance); } 
    */

    function testWithdrawFromMultipleFundersCheaper() public funded {
        uint160 numberofFunders = 10;
        uint160 startingFunder = 1;
        for (uint160 i = startingFunder; i < numberofFunders; i++) {
            hoax(address(i), send_value);
            fundme.fund{value: send_value}();
        }
        uint256 staringOwnerBalance = fundme.getOwner().balance;
        uint256 staringFuneMeBalance = address(fundme).balance;

        vm.startPrank(fundme.getOwner());
        fundme.cheaperWithdraw();
        vm.stopPrank();

        assertEq(address(fundme).balance, 0);
        assertEq(staringFuneMeBalance + staringOwnerBalance, fundme.getOwner().balance);
    }
}
