# hello-starknet

https://starknet.io/docs

### Install

```shell
pyenv install 3.9.14
pyenv local 3.9.14
python -m venv ./venv
source ./venv/bin/activate

pip3 install ecdsa fastecdsa sympy

pip3 install cairo-lang

# nile
sudo apt install -y libgmp3-dev

pip install cairo-nile
nile init

pytest tests

touch .env
# ACCOUNT_1=0x123456

# list starknet accounts
cat ~/.starknet_accounts/starknet_open_zeppelin_accounts.json


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

export CLASS_HASH=0x4880eb08829c9c36c2003a36258a75e81f3dc9054b0c358c80c5c133745ae53
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

- [ ] account abstraction
- [ ] remix

- [x] hello world
- [x] comments
- [x] felt
- [x] counter
- [x] function (input, outputs)
- [ ] revoked refs
- [ ] variable
  - [ ] let
  - [x] tempvar
  - [x] local?
  - [ ] storage
- [x] assert
- [x] if / else
- @storage_var - declares variable to be stored in storage
- @external - function can be called by other users and contracts
- @view - same as @external, in addition read-only
- [ ] builtins
- implicit args
- import
- [x] token
- [ ] wallet
- [x] math
- [ ] boolean expressions
- [x] error
- map
- [x] recursion
- [x] memory array
- [ ] state variable array?
- [x] array calldata
- [ ] pointer
- [x] struct
- struct calldata
- [x] tuple
- alloc
- [x] emit event
  - low level emit_event
- private data are not private
- [x] constructor
- storage - multi values, struct,
- [ ] storage with struct
- [ ] sender
- [x] block info
- [x] tx info
- [x] interface, calling other contracts
- [x] delegate call (library call)
- [x] factory
- L1 to L2, L2 to L1
- [ ] default entry point
- hash (keccak, pedersen)
- [x] pedersen hash
- ecdsa
- amm
- [ ] cast

# cairo

- [ ] registers

  - [x] ap
  - [ ] fp?
  - [ ] pc

- [ ] tools (nile)

### Cairo
