%lang starknet

const VALUE = 1234;

@view
func test() -> (x: felt, y: felt) {
    const VALUE_2 = 999;
    return (VALUE, VALUE_2);
}