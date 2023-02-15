%lang starknet

@contract_interface
namespace ICallee {
	func get_num(x: felt, y: felt) -> (num: felt) {
	}
}

@view
func call_get_num{syscall_ptr: felt*, range_check_ptr}(addr: felt) -> (num: felt) {
	// Or ICallee.get_num(contract_address = addr, x = 1, y = 2)
	let (res) = ICallee.get_num(addr, 1, 2);
	return (res,);
}
