%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@contract_interface
namespace ILib {
	func add(x: felt, y: felt) -> (num: felt) {
    }
	func get_count() -> (num: felt) {
    }
    func inc() -> () {
    }
}

// TODO: storage layout mismatch

@storage_var
func count() -> (res: felt) {
}


// Contract class hash: 0x23875e8fff2436317cb68d2c72265d22c84f8d3d8d453e92db0efb984bffb2d
@view
func call_add{
    syscall_ptr: felt*,
    range_check_ptr,
}(class_hash: felt, x: felt, y: felt) -> (z: felt) {
    let (res,) = ILib.library_call_add(class_hash = class_hash, x = x, y = y);
    return (res,);
}

@external
func call_inc{
    syscall_ptr: felt*,
    range_check_ptr,
}(class_hash: felt) -> () {
    ILib.library_call_inc(class_hash = class_hash);
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
