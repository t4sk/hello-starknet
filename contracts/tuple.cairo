%lang starknet

// return a tuple
@view
func example_1() -> (x: felt, y: felt) {
    return (1, 2);
}

// return a nested tuple
@view
func example_2() -> (x: (felt, felt), y: felt) {
    return ((1, 2), 3);
}

// use assert to check
@view
func example_3() -> (x: felt, y: felt) {
    let x = 1;
    let y = 2;

    assert (x, y) = (1, 2);
    // same as
    assert x = 1;
    assert y = 2;

    return (x, y);
}

// access tuple
@view
func example_4() -> (x: felt) {
    let t = (1,2,3);
    return (t[1],);
}