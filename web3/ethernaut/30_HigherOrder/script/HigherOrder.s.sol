// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {HigherOrder} from "../src/HigherOrder.sol";

contract HigherOrderScript is Script {
    HigherOrder public higherOrder;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        higherOrder = new HigherOrder();

        vm.stopBroadcast();
    }
}
