%lang starknet

struct Point {
	x: felt,
	y: felt,
}

@view
func make_point() -> (point: Point) {
	let p0 = Point(x=1, y=2);
	let p1 = Point(3, 4);
	// does not compile
	// return (p0.x, p0.y);
	return (p0,);
}
