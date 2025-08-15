// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {GoodSamaritan} from "../src/GoodSamaritan.sol";

contract GoodSamaritanScript is Script {
    GoodSamaritan public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new GoodSamaritan();

        vm.stopBroadcast();
    }
}
