%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

// Define a storage variable
@storage_var
func count() -> (res: felt) {
}

// TODO: builtins
// TODO: implicit args
@external
func inc{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() {
    let (res) = count.read();
    count.write(res + 1);
    return ();
}

@external
func dec{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}() {
    let (res) = count.read();
    count.write(res - 1);
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