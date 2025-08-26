// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

contract OurTokenTest is StdCheats, Test {
    OurToken public ourToken;
    DeployOurToken public deployer;

    address alice = address(1);
    address bob = address(2);

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();

        // fund alice with some tokens from deployer
        deal(address(ourToken), alice, 1000e18);
    }

    // --- existing tests ---
    function testInitialSupply() public {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    // --- transfer tests ---
    function testTransferSuccess() public {
        vm.prank(alice);
        ourToken.transfer(bob, 100e18);

        assertEq(ourToken.balanceOf(alice), 900e18);
        assertEq(ourToken.balanceOf(bob), 100e18);
    }

    function testTransferInsufficientBalance() public {
        vm.prank(bob);
        vm.expectRevert(); // bob has 0 tokens
        ourToken.transfer(alice, 1);
    }

    function testTransferEmitsEvent() public {
        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Transfer(alice, bob, 50e18);
        ourToken.transfer(bob, 50e18);
    }

    // --- allowances ---
    function testApproveAndAllowance() public {
        vm.prank(alice);
        ourToken.approve(bob, 200e18);

        assertEq(ourToken.allowance(alice, bob), 200e18);
    }

    function testTransferFromSuccess() public {
        vm.startPrank(alice);
        ourToken.approve(bob, 100e18);
        vm.stopPrank();

        // bob transfers tokens on behalf of alice
        vm.prank(bob);
        ourToken.transferFrom(alice, bob, 100e18);

        assertEq(ourToken.balanceOf(alice), 900e18);
        assertEq(ourToken.balanceOf(bob), 100e18);
        assertEq(ourToken.allowance(alice, bob), 0);
    }

    function testTransferFromInsufficientAllowance() public {
        vm.prank(alice);
        ourToken.approve(bob, 10e18);

        vm.prank(bob);
        vm.expectRevert();
        ourToken.transferFrom(alice, bob, 20e18);
    }

    // --- edge cases ---
    function testTransferZeroTokens() public {
        vm.prank(alice);
        ourToken.transfer(bob, 0);
        assertEq(ourToken.balanceOf(bob), 0);
    }

    function testApproveEmitsEvent() public {
        vm.prank(alice);
        vm.expectEmit(true, true, false, true);
        emit Approval(alice, bob, 123e18);
        ourToken.approve(bob, 123e18);
    }

    // events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
