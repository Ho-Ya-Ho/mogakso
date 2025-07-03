pragma solidity ^0.8.0;

import "forge-std/console.sol";

contract Telephone {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address _owner) public {
        console.log("start changeOwner() in Telephone");
        console.log("tx.origin : %s", tx.origin);
        console.log("msg.sender : %s", msg.sender);

        if (tx.origin != msg.sender) {
            owner = _owner;
        }
    }
}