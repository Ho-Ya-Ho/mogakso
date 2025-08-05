// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Attack} from "../src/Attack.sol";

contract GatekeeperTwoScript is Script {
    uint256 privateKey;

    address gatekeeperTwoAddress;
    Attack target;

    function setUp() public {
        gatekeeperTwoAddress = 0xe1b8aaC20EDD5b93019A0F7E3c2df82D19D9DA74;
        privateKey = vm.envUint("PRIVATE_KEY");
    }

    function run() public {
        setUp();

        vm.startBroadcast(privateKey);
        target = new Attack(gatekeeperTwoAddress);
        vm.stopBroadcast();
    }
}
