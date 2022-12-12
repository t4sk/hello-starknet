%lang starknet
%builtins range_check

@external
@view
func add(x: felt, y: felt) -> (z: felt) {
    return (x + y,);
}

@external
@view
func sub(x: felt, y: felt) -> (z: felt) {
    return (x - y,);
}

@external
@view
func mul(x: felt, y: felt) -> (z: felt) {
    return (x * y,);
}

// Solidity 7 / 3 = 2
// Cairo x such that 3 * x = 7
@external
@view
func div(x: felt, y: felt) -> (z: felt) {
    return (x / y,);
}