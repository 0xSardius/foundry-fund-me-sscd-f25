// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {FundMe} from "../src/FundMe.sol";
import {Test, console} from "forge-std/Test.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    address USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;

    function setUp() external {
        // fundMe = new FundMe(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollarIsFive() public view {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
        console.log(fundMe.MINIMUM_USD());
    }

    function testOwnerIsMsgSender() public view {
        assertEq(fundMe.i_owner(), address(this));
    }

    function testPriceFeedVersionIsAccurate() public view {
        assertEq(fundMe.getVersion(), 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert(); // Expect the transaction to revert
        fundMe.fund(); // send 0 value
    }

    function testFundUpdatesFundedDataStructure() public {
        fundMe.fund{value: SEND_VALUE}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(address(this));
        assertEq(amountFunded, SEND_VALUE);

    }
}
