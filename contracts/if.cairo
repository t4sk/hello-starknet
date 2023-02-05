%lang starknet

@view
func example_1(i: felt) -> (x: felt) {
    if (i == 10) {
        return (1,);
    }
    if (i == 20) {
        return (2,);
    } else {
        return (3,);
    }
}