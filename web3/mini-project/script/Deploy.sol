// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import "../src/InternalCallDemo.sol";

contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        // 1. ContractC 배포
        ContractC c = new ContractC();

        // 2. ContractB 배포 (C 주소 전달)
        ContractB b = new ContractB(address(c));

        // 3. ContractA 배포 (B 주소 전달)
        ContractA a = new ContractA(address(b));

        vm.stopBroadcast();

        console.log("ContractC:", address(c));
        console.log("ContractB:", address(b));
        console.log("ContractA:", address(a));
    }
}
