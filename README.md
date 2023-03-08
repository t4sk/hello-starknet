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

### StarkNet account

```shell
export STARKNET_NETWORK=alpha-goerli
export STARKNET_WALLET=starkware.starknet.wallets.open_zeppelin.OpenZeppelinAccount

# create account
starknet new_account
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
- [ ] Reference 'syscall_ptr' was revoked (function must be defined before called)
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
- [x] import
- [x] token
- [ ] wallet
- [x] math
- [ ] boolean expressions
- [x] error
- map
- [ ] visibility
- [ ] namespace
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
- [ ] L2 fees
- [ ] L1 -> L2 fees
- [ ] L2 -> L1 fees
- [x] L2 to L1
- [x] L1 to L2
- [x] default entry point
- [x] L1 default
- [ ] library call l1 handler
- hash (keccak, pedersen)
- [x] pedersen hash
- ecdsa
- [x] signature
- [x] amm
- token bridge
  - [ ] cancel
  - [ ] fee
- [ ] cast
- [ ] curve like amm?

# cairo

- [ ] registers

  - [x] ap
  - [ ] fp?
  - [ ] pc

- [ ] tools (nile)

# starks

### Compile and run cairo

```shell
cairo-compile test.cairo --output test_compiled.json

cairo-run \
  --program=test_compiled.json --print_output \
  --print_info --relocate_prints

cairo-compile felt.cairo --output felt_compiled.json
cairo-run --program felt_compiled.json --print_output --layout=small
```
