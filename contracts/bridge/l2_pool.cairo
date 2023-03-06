%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_not_zero
from starkware.starknet.common.messages import send_message_to_l1

@storage_var
func l1_contract() -> (res: felt) {
}

@external
func set_l1_contract{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(addr: felt) {
    l1_contract.write(addr);
    return ();
}

@view
func get_l1_contract{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (addr: felt) {
    let (addr) = l1_contract.read();
    return (addr,);
}

@external
func send_to_l1{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(to: felt, amount: felt) {
    let (l1) = l1_contract.read();
    with_attr error_message("l1 contract = 0") {
        assert_not_zero(l1);
    }

    // TODO: check L2 pool balance
    let payload_size = 2;
    let (payload: felt*) = alloc();
    assert payload[0] = to;
    assert payload[1] = amount;

    send_message_to_l1(l1, payload_size, payload);
    return ();
}

// TODO: maybe
@external
func deposit() {
    return ();
}

@external
func withdraw() {
    return ();
}
