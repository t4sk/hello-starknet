%lang starknet
from starkware.cairo.common.cairo_builtins import HashBuiltin

@event
func Log(selector: felt, calldata_len: felt, calldata: felt*) {
}

@storage_var
func count() -> (count: felt) {
}

@l1_handler
@raw_input
func __l1_default__{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(selector: felt, calldata_size: felt, calldata: felt*) {
    Log.emit(selector, calldata_size, calldata);

    let (res) = count.read();
    count.write(res + 1);

    return ();
}
