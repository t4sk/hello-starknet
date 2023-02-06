%lang starknet
%builtins pedersen range_check

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.hash import hash2

// homomorphic

@view
func get_hash{pedersen_ptr: HashBuiltin*, range_check_ptr}(x, y) -> (h: felt) {
    let (h) = hash2{hash_ptr=pedersen_ptr}(x,y);
    return (h,);
}