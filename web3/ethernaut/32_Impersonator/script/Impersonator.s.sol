// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Impersonator} from "../src/Impersonator.sol";

contract ImpersonatorScript is Script {
    Impersonator public impersonator;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        impersonator = new Impersonator();

        vm.stopBroadcast();
    }
}
