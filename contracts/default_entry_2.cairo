%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import library_call

@storage_var
func implementation_hash() -> (class_hash: felt) {
}

@constructor
func constructor{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(imp_hash: felt) {
    implementation_hash.write(imp_hash);
    return ();
}

@external
@raw_input
@raw_output
func __default__{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(selector: felt, calldata_size: felt, calldata: felt*) -> (retdata_size: felt, retdata: felt*) {
    // NOTE: output names must be retdata_size and retdata
    let (class_hash) = implementation_hash.read();

    let (retdata_size: felt, retdata: felt*) = library_call(
        class_hash = class_hash,
        function_selector = selector,
        calldata_size = calldata_size,
        calldata = calldata
    );

    return (retdata_size, retdata);
}

// class hash
// 0x1f6709bc0d13dc668a9fcfbc9f9c88d80981f8ca48ff9afbf037786cace8864
