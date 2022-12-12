%lang starknet
%builtins range_check

// Comment with double slash
const hello = 'hello'; 
const world = 'world';

@external
@view
func hello_world() -> (word0: felt, word1: felt) {
    return (hello, world);
}