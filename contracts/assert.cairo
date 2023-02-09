%lang starknet

@view
func test(x: felt) -> () {
    alloc_locals;
    // assign value to memory cell
    local a;
    assert a = 999;

    // verify 2 values are equal
    assert x = 123;

    return ();
}