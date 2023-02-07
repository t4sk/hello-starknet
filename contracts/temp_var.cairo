%lang starknet

@view
func example_1() -> (x: felt) {
    let x = 123;
    return (x,);
}

@view
func example_2() -> (x: felt) {
    tempvar x = 123;
    return (x,);
}

@view
func example_3() -> (x: felt) {
    // same as tempvar
    [ap] = 123, ap++;
    let x = [ap-1];

    return (x,);
}