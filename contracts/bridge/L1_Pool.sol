pragma solidity ^0.8;

// import "./IERC20.sol";

// 0xa2b26Aa8fE7b5C0D1C9288c372F0x077f460849240a1b8eb960142a7b71678dbd95947f56042926e33b27b5d79f1149f576bae4e4b
// 0x6b645db074f05775363d9b315c82cbb3A5337C50
contract L1Pool {
    event SendToL2(address indexed _from, uint indexed to, uint amount);
    event ReceiveFromL2(uint indexed to, uint amount);

    IStarknetCore public immutable starknetCore;
    // IERC20 public immutable token

    uint public l2;
    
    mapping(uint => uint) public balances;

    // receive_from_l1
    uint constant L2_SELECTOR = 598342674068027518481179578557554850038206119856216505601406522348670006916;
 
    // starknet core
    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore) {
        starknetCore = _starknetCore;
    }

    function setL2(uint addr) external {
        l2 = addr;
    }
    
    function sendToL2(uint to, uint amount) external payable {
        require(to > 0, "to = 0");
        require(amount > 0, "amount = 0");
        require(l2 != 0, "l2 = 0");
        // TODO: pull token
        
        uint256[] memory payload = new uint256[](2);
        payload[0] = to;
        payload[1] = amount;
 
        starknetCore.sendMessageToL2{value: msg.value}(l2, L2_SELECTOR, payload);
        
        emit SendToL2(msg.sender, to, amount);
    }
    
    function receiveFromL2(
        uint256 to,
        uint256 amount
    ) external {
        require(to > 0, "to = 0");
        require(amount > 0, "amount = 0");

        uint256 payloadSize = 2;
 
        uint256[] memory payload = new uint256[](payloadSize);
        payload[0] = to;
        payload[1] = amount;

        // This call reverts if the message doesn't exist on L1.
        starknetCore.consumeMessageFromL2(l2, payload);
        
        // TODO: push token
        emit ReceiveFromL2(to, amount);
    }
}

interface IStarknetCore {
    // TODO: what is bytes32?
    function sendMessageToL2(
        uint256 toAddress,
        uint256 selector,
        uint256[] calldata payload
    ) external payable returns (bytes32);

    function consumeMessageFromL2(
        uint256 fromAddress,
        uint256[] calldata payload
    ) external returns (bytes32);
}

interface IERC20 {
    function totalSupply() external view returns (uint);

    function balanceOf(address account) external view returns (uint);

    function transfer(address recipient, uint amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint amount) external returns (bool);

    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);
}


