// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MagicAnimalCarousel} from "../src/MagicAnimalCarousel.sol";

contract CounterTest is Test {
    MagicAnimalCarousel public counter;

    function setUp() public {
        counter = new MagicAnimalCarousel();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }
}
