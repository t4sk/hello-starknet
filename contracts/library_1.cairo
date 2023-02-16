%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func count() -> (res: felt) {
}

@external
func inc{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> () {
    let (res) = count.read();
    count.write(res + 1);
    return ();
}

@view
func get_count{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() -> (count: felt) {
    let (res) = count.read();
    return (count = res);
}

@view
func add(x: felt, y: felt) -> (z: felt) {
    return (x + y, );
}

