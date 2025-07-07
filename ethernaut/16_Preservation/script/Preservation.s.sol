// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";

contract PreservationScript is Script {
    Preservation public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new Preservation();

        vm.stopBroadcast();
    }
}
