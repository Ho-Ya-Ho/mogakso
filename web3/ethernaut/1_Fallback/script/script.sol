// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Fallback.sol";

contract FallbackScript is Script {
    Fallback public back;
    address public attacker;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        attacker = msg.sender;
        back = new Fallback();

        back.contribute{value: 0.0001 ether}();
        back.withdraw();

        // (bool success, ) = address(back).call{value: 0.0001 ether}("");
        // require(success, "Direct call failed");


        vm.stopBroadcast();
    }
}