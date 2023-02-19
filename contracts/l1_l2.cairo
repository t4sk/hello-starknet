%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func count() -> (count: felt) {
}

@l1_handler
func receive_l1_msg{
    syscall_ptr: felt*, 
    pedersen_ptr: HashBuiltin*, 
    range_check_ptr
}(from_address: felt, i: felt) {
    // NOTE: first input must be named from_address

    let (c) = count.read();
    count.write(c + i);

    return ();
}

@view
func get_count{
    syscall_ptr: felt*, 
    pedersen_ptr: HashBuiltin*, 
    range_check_ptr
}() -> (count: felt) {
    return count.read();
}
