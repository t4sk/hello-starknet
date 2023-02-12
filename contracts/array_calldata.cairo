%lang starknet

// compares 2 arrays a and b
// 0 - false
// 1 - true

@view
func compare_array(a_len: felt, a: felt*, b_len: felt, b: felt*) -> (b: felt) {
    if (a_len != b_len) {
        return (0,);
    }
    // a_len == b_len
    if (a_len == 0) {
        return (1,);
    }
    // a_len > 0
    if (a[0] == b[0]) {
        return compare_array(a_len - 1, &a[1], b_len - 1, &b[1]); 
    }

    return (0, );
}