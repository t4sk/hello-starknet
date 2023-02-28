%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_le, assert_nn_le, unsigned_div_rem
from starkware.starknet.common.syscalls import get_caller_address


const BALANCE_UPPER_BOUND = 2** 64;
const TOKEN_A = 1;
const TOKEN_B = 2;
const POOL_UPPER_BOUND = 2 ** 36;
const ACCOUNT_BALANCE_BOUND =  1073741;  // 2**30 // 1000.

// token balance
@storage_var
func pool_balance(token: felt) -> (balance: felt) {
}

// account id => token => balance
@storage_var
func account_balance(account: felt, token: felt) -> (balance: felt) {
}

func modify_account_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt, token: felt, amount: felt) {
    let (balance) = account_balance.read(account, token);
    // TODO: what is tempvar?
    tempvar new_balance = balance + amount;
    // assert not negative and less than upper bound
    assert_nn_le(new_balance, BALANCE_UPPER_BOUND - 1);
    account_balance.write(account=account, token=token, value=new_balance);
    return ();
}

@view
func get_account_token_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(account: felt, token: felt) -> (balance: felt) {
    return account_balance.read(account, token);
}

func set_pool_token_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(token: felt, balance: felt) {
    assert_nn_le(balance, BALANCE_UPPER_BOUND - 1);
    pool_balance.write(token, balance);
    return ();
}

@view
func get_pool_token_balance{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(token: felt) -> (balance: felt) {
    return pool_balance.read(token);
}

func get_token_out(token: felt) -> (token_out: felt) {
    if (token == TOKEN_A) {
        return (TOKEN_B,);
    } else {
        return (TOKEN_A,);
    }
}

func _swap{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(
    account: felt, token_in: felt, token_out: felt, amount_in: felt
) -> (amount_out: felt) {
    alloc_locals;

    // TODO: local?
    let (local amm_in_balance) = get_pool_token_balance(token=token_in);
    let (local amm_out_balance) = get_pool_token_balance(token=token_out);

    // TODO: unsigned_div_rem
    let (local amount_out, _) = unsigned_div_rem(
        amm_out_balance * amount_in, amm_in_balance + amount_in
    );

    // TODO: -amount_in?
    modify_account_balance(account=account, token=token_in, amount=-amount_in);
    set_pool_token_balance(token=token_in, balance=amm_in_balance + amount_in);

    modify_account_balance(account=account, token=token_out, amount=amount_out);
    set_pool_token_balance(token=token_out, balance=amm_out_balance - amount_out);

    return (amount_out,);
}

@external
func swap{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(token_in: felt, amount_in: felt) -> (amount_out: felt) {
    let (account) = get_caller_address();

    // Verify that token_in is either TOKEN_A or TOKEN_B.
    assert (token_in - TOKEN_A) * (token_in - TOKEN_B) = 0;

    assert_nn_le(amount_in, BALANCE_UPPER_BOUND - 1);

    let (account_amount_in_balance) = get_account_token_balance(
        account=account, token=token_in
    );

    assert_le(amount_in, account_amount_in_balance);

    let (token_out) = get_token_out(token_in);

    let (amount_out) = _swap(
        account=account,
        token_in=token_in,
        token_out=token_out,
        amount_in=amount_in
    );

    return (amount_out,);
}

// Demo
@external
func init_pool{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(token_a: felt, token_b: felt) {
    assert_nn_le(token_a, POOL_UPPER_BOUND - 1);
    assert_nn_le(token_b, POOL_UPPER_BOUND - 1);

    set_pool_token_balance(TOKEN_A, token_a);
    set_pool_token_balance(TOKEN_B, token_b);

    return ();
}

@external
func mint_tokens{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(token_a_amount: felt, token_b_amount: felt) {
    let (account) = get_caller_address();

    assert_nn_le(token_a_amount, ACCOUNT_BALANCE_BOUND - 1);
    assert_nn_le(token_b_amount, ACCOUNT_BALANCE_BOUND - 1);

    modify_account_balance(account, TOKEN_A, token_a_amount);
    modify_account_balance(account, TOKEN_B, token_b_amount);

    return ();
}
