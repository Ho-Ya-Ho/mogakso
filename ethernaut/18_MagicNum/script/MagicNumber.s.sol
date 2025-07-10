pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {MagicNum} from "../src/MagicNum.sol";

contract Solver {
    constructor() {
        assembly {
            mstore(0, 0x602a60405260206040f3)
            return(22, 10)
        }
    }
}

contract MagicNumberScript  is Script {
    address private constant MAGIC_NUM = 0x91B48DC1d009c11368dB3E5a9A16a458d58a1489;

    function run() external {
        vm.startBroadcast();

        Solver solver = new Solver();
        MagicNum(MAGIC_NUM).setSolver(address(solver));

        vm.stopBroadcast();
    }
}
