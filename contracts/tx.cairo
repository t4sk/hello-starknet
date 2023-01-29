%lang starknet

from starkware.starknet.common.syscalls import get_tx_info

@event
func Log(account: felt, fee: felt) {
}

@external
func test_tx{syscall_ptr: felt*, range_check_ptr}() {
    let (tx_info) = get_tx_info();
    Log.emit(tx_info.account_contract_address, tx_info.max_fee);
    return ();
}