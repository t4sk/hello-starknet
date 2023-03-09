pragma solidity ^0.8;

import "./IERC20.sol";
 
interface IStarknetCore {
    // TODO: what is bytes32?
    function sendMessageToL2(
        uint256 toAddress,
        uint256 selector,
        uint256[] calldata payload
    ) external returns (bytes32);

    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);
}

// TODO: cancel send
// 0x1E6F42f04D64D55ec08d6D4e6A7CB4a235E1c742
// 0x6CeC930579e5815145d6a674f793e919f90778ab
contract L1Pool {
    IStarknetCore public immutable starknetCore;
    // IERC20 public immutable token
    uint constant L2_SELECTOR = 598342674068027518481179578557554850038206119856216505601406522348670006916;

    uint public l2ContractAddress;
 
    // starknet core
    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore) {
        starknetCore = _starknetCore;
        // token = _token;
    }

    function setL2ContractAddress(uint addr) external {
        l2ContractAddress = addr;
    }

    // TODO: ERC20 token
    function sendToL2(uint to, uint amount) external {
        require(l2ContractAddress != 0, "l2 not set");

        uint256[] memory payload = new uint256[](2);
        payload[0] = to;
        payload[1] = amount;

        starknetCore.sendMessageToL2(l2ContractAddress, L2_SELECTOR, payload);
    }

    // 0x01f257e3c65408e8e55dfee75cfba4b26a3e93fbaed422aba0a7da27b8bae21d
    // function receiveFromL2(
    //     uint256 l2ContractAddress,
    //     uint256 to,
    //     uint256 amount
    // ) external {
    //     uint256 payloadSize = 2;
 
    //     uint256[] memory payload = new uint256[](payloadSize);
    //     payload[0] = to;
    //     payload[1] = amount;
 
    //     // This call reverts if the message doesn't exist on L1.
    //     starknetCore.consumeMessageFromL2(l2ContractAddress, payload);

    //     address _to = address(uint160(to));
    //     token.transfer(_to, amount);
    // }
}
