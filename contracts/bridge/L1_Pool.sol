pragma solidity ^0.8;

// import "./IERC20.sol";

contract L1Pool {
    IStarknetCore public immutable starknetCore;
    // IERC20 public immutable token

    uint public l2;
    
    mapping(uint => uint) public balances;
 
    // starknet core
    // 0xde29d060D45901Fb19ED6C6e959EB22d8626708e
    constructor(IStarknetCore _starknetCore) {
        starknetCore = _starknetCore;
        // token = _token;
    }

    function setL2(uint addr) external {
        l2 = addr;
    }
    
    event SendToL2(address indexed _from, uint indexed to, uint amount);
    
    function sendToL2(uint to, uint amount) external {
        require(to > 0, "to = 0");
        require(amount > 0, "amount = 0");
        // TODO: pull token
        
        // TODO:
        uint256 l2Selector = 0;
        uint256[] memory payload = new uint256[](2);
        payload[0] = to;
        payload[1] = amount;
 
        starknetCore.sendMessageToL2(l2, l2Selector, payload);
        
        emit SendToL2(msg.sender, to, amount);
    }
    
    event ReceiveFromL2(uint indexed to, uint amount);
    
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
    ) external returns (bytes32);

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


