%lang starknet

from starkware.cairo.common.alloc import alloc

@view
func get_sum(n: felt) -> (sum: felt) {
    let (sum) = get_sum_recur(0, 1, n);
    return (sum,);
}

func get_sum_recur(sum: felt, i: felt, n: felt) -> (sum: felt) {
    if (i == n) {
        return (sum + n,);
    }
    return get_sum_recur(sum + i, i + 1, n);
}

@view
func get_array_sum() -> (sum: felt) {
    // initialize array
    let (array_ptr : felt*) = alloc();
    assert[array_ptr] = 10;
    assert[array_ptr + 1] = 20;
    assert[array_ptr + 2] = 30;

    return get_array_sum_recur(array_ptr, 3);
}

func get_array_sum_recur(array_ptr: felt*, len: felt) -> (sum: felt) {
    if (len == 0) {
        return (0,);
    }
    let (sum, ) =get_array_sum_recur(array_ptr + 1, len - 1);

    return ([array_ptr] + sum,);
}