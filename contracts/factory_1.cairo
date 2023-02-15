%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func owner() -> (owner: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr
}(owner_addr: felt) {
    owner.write(owner_addr);
    return ();
}

@external
func get_owner{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr
}() -> (owner: felt) {
    let (res) = owner.read();
	return (res,);
}
