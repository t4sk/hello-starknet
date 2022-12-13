# hello-starknet

https://starknet.io/docs

### Install

```shell
python -m venv ./venv
source ./venv/bin/activate

pip3 install ecdsa fastecdsa sympy

pip3 install cairo-lang
```

### Compile and run cairo

```shell
cairo-compile test.cairo --output test_compiled.json

cairo-run \
  --program=test_compiled.json --print_output \
  --print_info --relocate_prints

cairo-compile felt.cairo --output felt_compiled.json
cairo-run --program felt_compiled.json --print_output --layout=small
```

### StarkNet account

```shell
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

# create account
starknet new_account
```

### Starknet compile

```shell
starknet-compile contracts/hello.cairo \
    --output compiled/hello.json \
    --abi abi/hello.json
```

### Starknet deploy

```shell
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

starknet declare --contract compiled/hello.json

export CLASS_HASH=0x5f30a6f6e00f2d8a2a60d464ebdeab17bb4c49a90c6aff4e2d2e2da3b11c8f7
starknet deploy --class_hash $CLASS_HASH
```

### Starknet interact

```shell
export CONTRACT_ADDR=0x051af99b7098758b13391fe4a19aa938734365aac9fe1d6420e0234c95c2f675

starknet invoke \
    --address $CONTRACT_ADDR \
    --abi abi/contract_abi.json \
    --function increase_balance \
    --inputs 1234

starknet call \
    --address $CONTRACT_ADDR \
    --abi abi/contract_abi.json \
    --function get_balance
```

### Nile

```shell
pip install cairo-nile openzeppelin-cairo-contracts

nile compile
nile node

```

### Topics

### Starknet

- [x] hello world
- [x] comments
- [x] felt
- [x] counter
- builtins (range_check)
- implicit args
- function (input, outputs)
- wallet
- token
- math
- map
- recursion
- array
- import
- emit event
- private data are not private
- constructor
- storage - multi values, struct,
- array, tuple, struct calldata
- sender, block info
- interface, calling other contracts
- delegate call (library call)
- factory
- events
- L1 to L2, L2 to L1
- default
- ecdsa
- amm

### Cairo
