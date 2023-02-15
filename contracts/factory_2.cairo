%lang starknet
from starkware.cairo.common.bool import FALSE
from starkware.starknet.common.syscalls import deploy

@event
func deployed(contract_addr: felt) {
}

@external
func deploy_contract{
    syscall_ptr: felt*,
    range_check_ptr,
}(class_hash: felt, salt: felt, owner_addr: felt) {
    let (contract_addr) = deploy(
        // class hash of contract to deploy
        class_hash = class_hash,
        // arbitrary value used to determine the address of the new contract
        contract_address_salt = salt,
        // size of constructor arguments
        constructor_calldata_size = 1,
        // pointer to an array containing the arguments
        constructor_calldata = cast(new (owner_addr,), felt*),
        // TRUE = contract address computed from zero address
        // FALSE = contract address computed from deployer's address
        deploy_from_zero = FALSE
    );

    deployed.emit(contract_addr);
    return ();
}
