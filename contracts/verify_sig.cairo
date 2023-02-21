%lang starknet

from starkware.cairo.common.cairo_builtins import (HashBuiltin, SignatureBuiltin)
from starkware.cairo.common.hash import hash2
from starkware.cairo.common.signature import verify_ecdsa_signature

@external
func verify{
    pedersen_ptr: HashBuiltin*,
    ecdsa_ptr: SignatureBuiltin*,
}(signer: felt, msg: felt, sig: (felt, felt)) -> () {
    // hash2(x, 0) = hash2(x)
    let (msg_hash) = hash2{hash_ptr=pedersen_ptr}(msg, 0);

    // reverts if signature is invalid
    verify_ecdsa_signature(
        message = msg_hash,
        public_key = signer,
        signature_r = sig[0],
        signature_s = sig[1]
    );

    return ();
}
