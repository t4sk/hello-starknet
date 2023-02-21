from starkware.crypto.signature.signature import (
    pedersen_hash, private_to_stark_key, sign
)

private_key = 12345
message_hash = pedersen_hash(4321)
public_key = private_to_stark_key(private_key)

signature = sign(
    msg_hash=message_hash, priv_key=private_key
)

print(f'Public key: {public_key}')
print(f'Signature: {signature}')
