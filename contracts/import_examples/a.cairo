%lang starknet

const NUM = 123;

namespace A {
    func add(x: felt, y: felt) -> (z: felt) {
        return (x + y,);
    }
}
