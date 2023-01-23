%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.starknet.common.syscalls import get_caller_address

struct Point {
    x: felt,
    y: felt,
}

@event
func MessageReceived(a: felt, b: felt) {
}

@event
func LogPoint(point: Point) {
}

@external
func log_1{syscall_ptr: felt*, range_check_ptr}() {
    MessageReceived.emit(1, 2);
    return ();
}

@external
func log_2{syscall_ptr: felt*, range_check_ptr}() {
    let p = Point(3, 4);
    LogPoint.emit(p);
    return ();
}