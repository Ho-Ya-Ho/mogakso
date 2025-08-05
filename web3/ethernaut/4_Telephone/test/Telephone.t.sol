// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {Attack, Telephone} from "../src/Attack.sol";

contract TelephoneTest is Test {
    function test_Attack() public {
        console.log("start TelephoneTest");
        address telephoneAddress = address(new Telephone());

        Attack attack = new Attack(telephoneAddress);
        attack.attack();
    }
}
