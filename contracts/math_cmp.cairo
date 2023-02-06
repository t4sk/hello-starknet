%lang starknet
%builtins range_check

from starkware.cairo.common.math_cmp import is_not_zero, is_nn, is_le, is_in_range

@view
func example_1(i: felt) -> (b: felt) {
    return (is_not_zero(i),);
}

@view
func example_2{range_check_ptr}(i: felt) -> (b: felt) {
    return (is_nn(i),);
}

@view
func example_3{range_check_ptr}(i: felt, j: felt) -> (b: felt) {
    return (is_le(i, j),);
}

@view
func example_4{range_check_ptr}(i: felt, j: felt, k: felt) -> (b: felt) {
    // j <= i <= k?
    return (is_in_range(i, j, k),);
}