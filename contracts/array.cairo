%lang starknet
%builtins range_check

from starkware.cairo.common.alloc import alloc

@view
func read_array{range_check_ptr}(index : felt) -> (value : felt) {
    // A pointer to the start of an array in memory.
    let (felt_array : felt*) = alloc();

    // [felt_array] is 'the value at the pointer'.
    // 'assert' sets the value at index
    assert [felt_array] = 9;
    assert [felt_array + 1] = 8;
    assert [felt_array + 2] = 7;  // Set index 2 to value 7.
    assert [felt_array + 9] = 18;
    // Access the list at the selected index.
    let val = felt_array[index];
    return (value=val);
}