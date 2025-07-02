pragma solidity ^0.8.13;

contract PigBank {
    mapping(address => uint256) private _balances;

    receive() external payable {
        require(msg.value > 0, "You must send some Ether");
        _balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Insufficient balance");
        _balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    function getMyBalance() public view returns (uint256) {
        return _balances[msg.sender];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
