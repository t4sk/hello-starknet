%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn


@view
func test{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr,
}(x: felt) -> () {
    with_attr error_message("Amount must be positive. Got: {x}.") {
        assert_nn(x);
    }

    return ();
}