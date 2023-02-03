%lang starknet

// only values that may change over time are held within designated registers
// ap - allocation pointer - points to free memory cell
// fp - frame pointer - points to the frame of the current function. 
//      The addresses of all the function’s arguments and local variables are 
//      relative to the value of this register. When a function starts, 
//      it is equal to ap. But unlike ap, the value of fp remains the same 
//      throughout the scope of a function.
// pc - pc (program counter) - points to the current instruction

@view
func test_1(x: felt) -> (y: felt) {
    // compute x^4 + x
    let x0 = ap;
    [x0] = x, ap++;

    // x^2 = x * x
    [ap] = [ap - 1] * [ap - 1], ap++;
    // x^4 = x^2 * x^2
    [ap] = [ap - 1] * [ap - 1], ap++;

    // x^4 + x
    [ap] = [ap - 1] + [x0], ap++;

    return ([ap - 1],);
}

@view
func test_2(x: felt) -> (y: felt) {
    // compute x^3 + 23x^2 + 45x + 67

    // x^2
    let x2 = ap;
    [x2] = x * x, ap++;

    // x^3
    let x3 = ap;
    [x3] = [x2] * x, ap++;

    // 23x^2
    [ap] = [x2] * 23, ap++;
    // x^3 + 23x^2
    [ap] = [x3] + [ap - 1], ap++;

    // 45x
    [ap] = x * 45, ap++;
    // x^3 + 23x^2 + 45x
    [ap] = [ap - 2] + [ap - 1], ap++;

    // x^3 + 23x^2 + 45x + 67
    return ([ap - 1] + 67,);
}