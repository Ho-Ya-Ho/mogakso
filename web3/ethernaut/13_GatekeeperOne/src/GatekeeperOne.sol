pragma solidity ^0.8.0;

import {console} from "forge-std/Test.sol";

contract GatekeeperOne {
    address public entrant;

    modifier gateOne() {
        console.log("start one");
        require(msg.sender != tx.origin);
        _;
    }

    modifier gateTwo() {
        console.log("start two");
        require(gasleft() % 8191 == 0);
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        console.log("start 3-1");
        require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
        console.log("start 3-2");
        require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        console.log("start 3-3");
        require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
        _;
    }

    function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
        entrant = tx.origin;
        return true;
    }
}