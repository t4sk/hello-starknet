%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import assert_le

@storage_var
func total_supply() -> (total_supply: felt) {
}

@storage_var
func balance_of(account: felt) -> (balance: felt) {
}

@external
func mint{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt, amount: felt) -> () {
    // TODO: assert amount >= 0?
    let (bal) = balance_of.read(account);
    let (new_bal) = _add(bal, amount);
    balance_of.write(account, new_bal);

    let (total) = total_supply.read();
    let (new_total) = _add(total, amount);
    total_supply.write(new_total);

    return ();
}

@external
func burn{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(amount: felt) -> () {
    // TODO: what is alloc_local?
    alloc_locals;
    let (local caller) = get_caller_address();

    let (bal) = balance_of.read(caller);
    let (new_bal) = _sub(bal, amount);
    balance_of.write(caller, new_bal);

    let (total) = total_supply.read();
    let (new_total) = _sub(total, amount);
    total_supply.write(new_total);

    return ();
}

@external
func transfer{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(to: felt, amount: felt) -> () {
    alloc_locals;
    let (local caller) = get_caller_address();

    let (caller_bal) = balance_of.read(caller);
    let (new_caller_bal) = _sub(caller_bal, amount);
    balance_of.write(caller, new_caller_bal);

    let (recevier_bal) = balance_of.read(to);
    let (new_receiver_bal) = _add(recevier_bal, amount);
    balance_of.write(to, new_receiver_bal);

    return ();
}

func _add{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr
}(x: felt, y: felt) -> (z: felt) {
    // TODO: let, tempvar, local
    let z = x + y;
    // TODO: compares
    assert_le(x, z);
    return (z,);
}

func _sub{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr
}(x: felt, y: felt) -> (z: felt) {
    // TODO: assert x, y >= 0?
    assert_le(y, x);
    let z = x - y;
    return (z,);
}


@view
func get_total_supply{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (total_supply: felt) {
    let (res) = total_supply.read();
    return (res,);
}

@view
func get_balance_of{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt) -> (balance: felt) {
    let (res) = balance_of.read(account);
    return (res,);
}