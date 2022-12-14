%lang starknet

@view
func func_1(x: felt, y: felt) -> (out1: felt, out2: felt) {
    // Positional
    // return (123, 456);

    // Named
    return (out1 = 123, out2 = 456);
}

// Return single output
@view
func func_2() -> (out: felt) {
    return (1,);
}

// Function must end with return statement 
// Return empty tuple
@view
func test() -> () {
    // Calling functions
    func_1(1, 2);
    func_1(x= 1, y = 2);
    let x = func_1(1, 2);
    let (val1, val2) = func_1(1, 2);
  
    return ();
}