// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8;
 
interface IStarknetCore {
    function sendMessageToL2(
        uint256 toAddress,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);
}
 
contract L1_L2_default {
    IStarknetCore starknetCore;
 
    uint256 constant L2_SELECTOR = 123;
 
    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore) {
        starknetCore = _starknetCore;
    }
 
    function sendMessage(
        uint256 l2ContractAddr,
        uint256 l2Selector,
        uint256 i
    ) external {
        uint256[] memory payload = new uint256[](1);
        payload[0] = i;
        starknetCore.sendMessageToL2(l2ContractAddr, l2Selector, payload);
    }
}
