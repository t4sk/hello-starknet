#!/bin/bash

export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

export CONTRACT=call_2

# compile
starknet-compile contracts/$CONTRACT.cairo \
    --output compiled/$CONTRACT.json \
    --abi abi/$CONTRACT.json


# declar
starknet declare --contract compiled/$CONTRACT.json

# deploy
export CLASS_HASH=0x21009bf285d7cb86a330e669fbda5dcdcc19c5503a49db1f6778bfb9da7e5e8
starknet deploy --class_hash $CLASS_HASH
# starknet deploy --class_hash $CLASS_HASH --inputs 123

# call
export CONTRACT_1=0x0482d91140c14e1631177e4731775b87a2ef62fb8dbd24ce759c3b2c3a2c89bb
export CONTRACT_ADDR=0x0704158bdb0dd1bf35a29d90f73051624f7800ab3f4fca05b4518690dc951cc4

starknet call \
    --address $CONTRACT_ADDR \
    --abi abi/$CONTRACT.json \
    --function call_get_num --inputs $CONTRACT_1

