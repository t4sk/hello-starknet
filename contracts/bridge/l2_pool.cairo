%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.math import assert_not_zero, assert_nn_le
from starkware.starknet.common.syscalls import get_caller_address
from starkware.starknet.common.messages import send_message_to_l1

// events //
// TODO: index?
@event
func deposit_event(caller: felt, amount: felt) {
}

@event
func withdraw_event(caller: felt, amount: felt) {
}

@event
func receive_from_l1_event(from_address: felt, to: felt, amount: felt) {
}

@event
func send_to_l1_event(caller: felt, to: felt, amount: felt) {
}

// storage variables //
@storage_var
func l1_contract() -> (res: felt) {
}

@storage_var
func balances(account: felt) -> (res: felt) {
}

@storage_var
func from_addr() -> (res: felt) {
}

@storage_var
func to_addr() -> (res: felt) {
}

@storage_var
func l1_amount() -> (res: felt) {
}

@view
func get_from_addr{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (addr: felt) {
    let (addr) = from_addr.read();
    return (addr,);
}

@view
func get_to_addr{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (addr: felt) {
    let (addr) = to_addr.read();
    return (addr,);
}

@view
func get_l1_amount{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (addr: felt) {
    let (addr) = l1_amount.read();
    return (addr,);
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
func get_balance_of{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt) -> (res: felt) {
    return balances.read(account);
}

// TODO: cancel send
@l1_handler
func receive_from_l1{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(from_address: felt, to: felt, amount: felt) {
    // TODO: require from_address = l1 contract
    from_addr.write(from_address);
    to_addr.write(to);
    l1_amount.write(amount);

    receive_from_l1_event.emit(from_address, to, amount);
    return ();
}

@external
func send_to_l1{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(to: felt, amount: felt) {
    // TODO: why removing this does not compile?
    alloc_locals;

    // TODO: assert caller != 0?
    let (caller) = get_caller_address();

    // TODO: check to is valid L1 address

    let (l1_addr) = l1_contract.read();
    with_attr error_message("l1 contract = 0") {
        assert_not_zero(l1_addr);
    }

    _withdraw(caller, amount);

    // TODO: check L2 pool balance
    let payload_size = 2;
    let (payload: felt*) = alloc();
    assert payload[0] = to;
    assert payload[1] = amount;

    send_message_to_l1(l1_addr, payload_size, payload);

    // send_to_l1_event.emit(caller, to, amount);
    return ();
}

// TODO: maybe
@external
func deposit{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(amount: felt) {
    // TODO: assert caller != 0?
    let (caller) = get_caller_address();
    let (bal) = balances.read(caller);

    // TODO: overflow check
    balances.write(caller, bal + amount);

    deposit_event.emit(caller, amount);

    return ();
}

func _withdraw{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt, amount: felt) {
    with_attr error_message("account = 0") {
        assert_not_zero(account);
    }

    let (bal) = balances.read(account);

    with_attr error_message("amount > balance") {
        assert_nn_le(amount, bal);
    }

    // TODO: underflow?
    balances.write(account, bal - amount);

    return ();
}

@external
func withdraw{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(amount: felt) {
    // TODO: assert caller != 0?
    let (caller) = get_caller_address();

    with_attr error_message("account = 0") {
        assert_not_zero(account);
    }

    let (bal) = balances.read(account);

    with_attr error_message("amount > balance") {
        assert_nn_le(amount, bal);
    }

    // TODO: underflow?
    balances.write(account, bal - amount);

    withdraw_event.emit(caller, amount);

    return ();
}
