// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Motorbike} from "../src/Motorbike.sol";

contract CounterScript is Script {
    Motorbike public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new Motorbike();

        vm.stopBroadcast();
    }
}
