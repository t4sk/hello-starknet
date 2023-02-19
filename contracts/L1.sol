pragma solidity ^0.8;
 
interface IStarknetCore {
    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);
}

// 0x1E6F42f04D64D55ec08d6D4e6A7CB4a235E1c742
contract L2ToL1 {
    IStarknetCore starknetCore;
 
    uint256 public sum;

    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore) {
        starknetCore = _starknetCore;
    }

    // 0x01f257e3c65408e8e55dfee75cfba4b26a3e93fbaed422aba0a7da27b8bae21d
    function add(
        uint256 l2ContractAddress,
        uint256 x,
        uint256 y
    ) external {
        uint256 payloadSize = 2;
 
        uint256[] memory payload = new uint256[](payloadSize);
        payload[0] = x;
        payload[1] = y;
 
        // This call reverts if the message doesn't exist on L1.
        starknetCore.consumeMessageFromL2(l2ContractAddress, payload);
 
        // If we got to this point everything is ok and we can compute
        //  the sum and store it in the storage variable.
        sum = x + y;
    }
}
