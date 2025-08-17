// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Switch} from "../src/Switch.sol";

contract SwitchScript is Script {
    Switch public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Switch = new Switch();

        vm.stopBroadcast();
    }
}
