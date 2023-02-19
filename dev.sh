#!/bin/bash

export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

export CONTRACT=factory_2

# compile
starknet-compile contracts/$CONTRACT.cairo \
    --output compiled/$CONTRACT.json \
    --abi abi/$CONTRACT.json


# declar
starknet declare --contract compiled/$CONTRACT.json

# deploy
export CLASS_HASH_1=0x54e93643099bd6107fc584546d51eb2a3de77756d1740f529a2de49311e78ea
export CLASS_HASH=0x3b6f0397d3f3dbf57b4bb2699d018da44c39424f0bb19aae86116bdbb2d53ce
starknet deploy --class_hash $CLASS_HASH
# starknet deploy --class_hash $CLASS_HASH --inputs 123

# call
export CONTRACT_ADDR=0x021e82a75cadb7300eae5a811f24e884c04c479e9f51b58f79febee56eb63f45
export SALT=1
export OWNER=0x021e82a75cadb7300eae5a811f24e884c04c479e9f51b58f79febee56eb63f45


starknet invoke \
    --address $CONTRACT_ADDR \
    --abi abi/$CONTRACT.json \
    --function deploy_contract --inputs $CLASS_HASH_1 1 $OWNER 

