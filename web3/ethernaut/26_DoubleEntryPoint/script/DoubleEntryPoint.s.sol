// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {DoubleEntryPoint} from "../src/DoubleEntryPoint.sol";

contract DoubleEntryPointScript is Script {
    DoubleEntryPoint public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new DoubleEntryPoint();

        vm.stopBroadcast();
    }
}
