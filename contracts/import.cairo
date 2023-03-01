%lang starknet

from contracts.import_example_1 import NUM
from contracts.import_examples.a import NUM as MY_NUM, A

@view
func testAdd(x: felt, y: felt) -> (z: felt) {
    return A.add(x, y);
}


