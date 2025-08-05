// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractC {
    function pingC() public pure returns (string memory) {
        return "pong from C";
    }
}

contract ContractB {
    ContractC public c;
    constructor(address _c) {
        c = ContractC(_c);
    }

    function pingB() public view returns (string memory) {
        return c.pingC(); // internal call to ContractC
    }
}

contract ContractA {
    ContractB public b;
    constructor(address _b) {
        b = ContractB(_b);
    }

    function pingA() public view returns (string memory) {
        return b.pingB(); // internal call to ContractB (which calls C)
    }
}
