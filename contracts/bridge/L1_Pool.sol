pragma solidity ^0.8;

import "./IERC20.sol";
 
interface IStarknetCore {
    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);
}

// 0x1E6F42f04D64D55ec08d6D4e6A7CB4a235E1c742
contract L1Pool {
    IStarknetCore public immutable starknetCore;
    IERC20 public immutable token

    uint public l2ContractAddress;
    mapping(address => uint) public balances;
 
    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore, IERC20 _token) {
        starknetCore = _starknetCore;
        token = _token;
    }

    function setL2ContractAddress(address addr) external {
        l2ContractAddress = addr;
    }

    // 0x01f257e3c65408e8e55dfee75cfba4b26a3e93fbaed422aba0a7da27b8bae21d
    function receiveFromL2(
        uint256 l2ContractAddress,
        uint256 to,
        uint256 amount
    ) external {
        uint256 payloadSize = 2;
 
        uint256[] memory payload = new uint256[](payloadSize);
        payload[0] = to;
        payload[1] = amount;
 
        // This call reverts if the message doesn't exist on L1.
        starknetCore.consumeMessageFromL2(l2ContractAddress, payload);

        address _to = address(uint160(to));
        token.transfer(_to, amount);
    }

    function sendToL2(uint to, uint amount) external {
        balances[msg.sender] -= amount;

        uint256[] memory payload new uint256[](2);
        payload[0] = to;
        payload[1] = amount;

        starknetCore.sendMessageToL2(l2ContractAddress, L2_SELECTOR, payload);
    }

    function deposit(uint amount) external {
        balances[msg.sender] += amount;
    }

    function withdraw(uint amount) external {
        balances[msg.sender] -= amount;
    }

}
