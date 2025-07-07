// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/GatekeeperOne.sol";
import "../src/Attack.sol";

contract GateKeeperOneTest is Test {
    // Preservation.sol public counter;

    // function setUp() public {
    //     counter = new Preservation.sol();
    //     counter.setNumber(0);
    // }

    function test_Attack() public {
        console.log("start GateKeeperOneTest");
        address gateKeeperOneAddress = address(new GatekeeperOne());

        Attack attack = new Attack(gateKeeperOneAddress);
        attack.attack();
    }

    
}
