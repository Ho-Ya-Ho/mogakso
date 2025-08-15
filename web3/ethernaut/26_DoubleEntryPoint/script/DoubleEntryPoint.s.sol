// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/DoubleEntryPoint.sol";
import {DoubleEntryPoint} from "../src/DoubleEntryPoint.sol";
import {Script, console} from "forge-std/Script.sol";

contract DoubleEntryPointScript is Script {
    DoubleEntryPoint public doubleEntryPoint;

    function setUp() public {
        doubleEntryPoint = DoubleEntryPoint(0xaEdBDf054DaF39231c213b6F965270AB61683Df8);
    }

    function run() public {
        vm.startBroadcast();

        Forta forta = doubleEntryPoint.forta();
        FakeDetectionBot fakeDetectionBot = new FakeDetectionBot(address(forta));
        forta.setDetectionBot(address(fakeDetectionBot));

        vm.stopBroadcast();
    }
}

contract FakeDetectionBot is IDetectionBot {
    IForta public forta;

    constructor(address fortaAddress) {
        forta = IForta(fortaAddress);
    }

    function handleTransaction(address user, bytes calldata) external override {
        forta.raiseAlert(user);
    }
}
