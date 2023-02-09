%lang starknet

@view
func test() -> (x: felt) {
    alloc_locals;
    local a = 3;
    // [fp] = [fp] * [fp] + 1
    // a = a*a + 1;

    // TODO: fix
    // fails 3 != 9
    a = a * a;
    a = a + 1;
    return (a,);
}