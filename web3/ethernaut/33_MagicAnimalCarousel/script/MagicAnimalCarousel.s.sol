// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MagicAnimalCarousel} from "../src/MagicAnimalCarousel.sol";

contract MagicAnimalCarouselScript is Script {
    MagicAnimalCarousel public counter;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        counter = new MagicAnimalCarousel();

        vm.stopBroadcast();
    }
}
