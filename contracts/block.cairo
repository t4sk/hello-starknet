%lang starknet

from starkware.starknet.common.syscalls import (get_block_number, get_block_timestamp)

@view
func get_block_info{syscall_ptr: felt*}() -> (num: felt, timestamp: felt) {
    let (block_number) = get_block_number();
    let (timestamp) = get_block_timestamp();
    return (num=block_number, timestamp=timestamp);
}