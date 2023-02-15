%lang starknet

@view
func get_num(x: felt, y: felt) -> (num: felt) {
	return (x + y + 1,);
}
