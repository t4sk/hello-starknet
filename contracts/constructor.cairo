%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func owner() -> (res: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*, 
    pedersen_ptr: HashBuiltin*, 
    range_check_ptr
}(owner_addr: felt) {
    owner.write(value=owner_addr);
    return ();
}

@view
func get_owner{
    syscall_ptr: felt*, 
    pedersen_ptr: HashBuiltin*, 
    range_check_ptr
}() -> (addr: felt) {
    let (addr) = owner.read();
    return(addr=addr);
}