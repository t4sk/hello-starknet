%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from starkware.cairo.common.math import assert_not_zero, assert_le

@event
func Transfer(_from: felt, to: felt, value: felt) {
}

@event
func Approve(owner: felt, spender: felt, value: felt) {
}

@storage_var
func owner() -> (owner: felt) {
}

@storage_var
func total_supply() -> (total_supply: felt) {
}

@storage_var
func balances(account: felt) -> (balance: felt) {
}

@storage_var
func allowances(owner: felt, spender: felt) -> (allowance: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() {
    let (caller) = get_caller_address();
    owner.write(caller);
    return ();
}

func assert_only_owner{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() {
    let (owner_addr) = owner.read();
    let (caller) = get_caller_address();

    // TODO: when is caller == 0?
    with_attr error_message("Caller is zero address") {
        assert_not_zero(caller);
    }
    with_attr error_message("Not authorized") {
        assert owner_addr = caller;
    }
    return ();
}

@external
func set_owner{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(new_owner: felt) {
    assert_only_owner();

    with_attr error_message("new owner = 0") {
        assert_not_zero(new_owner);
    }

    owner.write(new_owner);
    return ();
}

@view
func get_owner{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (owner: felt) {
    let (res) = owner.read();
    return (res,);
}

@external
func mint{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt, amount: felt) -> () {
    assert_only_owner();

    // TODO: assert amount >= 0?
    let (bal) = balances.read(account);
    let (new_bal) = _add(bal, amount);
    balances.write(account, new_bal);

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

    let (bal) = balances.read(caller);
    let (new_bal) = _sub(bal, amount);
    balances.write(caller, new_bal);

    let (total) = total_supply.read();
    let (new_total) = _sub(total, amount);
    total_supply.write(new_total);

    return ();
}

@external
func approve{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(spender: felt, amount: felt) {
    // TODO: check amount

    let (caller) = get_caller_address();

    with_attr error_message("Caller is zero address") {
        assert_not_zero(caller);
    }
    with_attr error_message("Spender is zero address") {
        assert_not_zero(spender);
    }

    allowances.write(caller, spender, amount);

    return ();
}

@external
func transfer{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(to: felt, amount: felt) {
    alloc_locals;
    let (local caller) = get_caller_address();

    let (caller_bal) = balances.read(caller);
    let (new_caller_bal) = _sub(caller_bal, amount);
    balances.write(caller, new_caller_bal);

    let (recevier_bal) = balances.read(to);
    let (new_receiver_bal) = _add(recevier_bal, amount);
    balances.write(to, new_receiver_bal);

    return ();
}

@external
func tranfer_from{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(_from: felt, to: felt, amount: felt) {
    return ();
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
    let (res) = balances.read(account);
    return (res,);
}

@view
func get_allowance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(owner: felt, spender: felt) -> (allowance: felt) {
    let (res) = allowances.read(owner, spender);
    return (res,);
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

