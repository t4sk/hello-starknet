%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.starknet.common.messages import send_message_to_l1

@external
func send_message{syscall_ptr: felt*}(l1_contract_addr: felt, x: felt, y: felt) -> () {
    let payload_size = 2;
    let (payload: felt*) = alloc();
    assert payload[0] = x;
    assert payload[1] = y;

    send_message_to_l1(l1_contract_addr, payload_size, payload);
    return ();
}
