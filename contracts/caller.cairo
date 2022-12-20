%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

@storage_var
func caller() -> (res: felt) {
}

@external
func set_caller{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> () {
    let (addr) = get_caller_address();
    caller.write(addr);
    return ();
}

@view
func get_last_caller{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    let (res) = caller.read();
    return (res,);
}

// TODO: why caller address is 0?
@view
func get_caller{syscall_ptr: felt*}() -> (res: felt) {
    let (addr) = get_caller_address();
    return (addr,);
}