# Testing Starknet Contracts

### 
- **Contract Interfaces**
    - They defines the structure and behaviour of a contract
    - They serve as the contract's public ABI
    - Each time a contract interface is defined, two dispatchers are automatically created and exported by the compiler.
        1. The contract dispatcher. e.g `IERC20Dispatcher` (struct)
        2. The Library dispatcher. e.g `IERC20LibraryDispatcher` (struct)
    - Compiler also generates a trait `IERC20DispatcherTrait`, which allows us to call the functions defined inside the interface from the dispatcher struct
    - Contract dispatchers - Used to call functions from another contracts.
    - Library dispatchers - Used to call classes. Stateless, similar to delegate call in Solidity).

### 
- **Drop and Serde** are required to properly serialize arguments passed to the entrypoints and deserialize their outputs.

###
- [Desnap Operator](https://book.cairo-lang.org/ch04-02-references-and-snapshots.html#desnap-operator)
    - A desnap operator, denoted by `*`, is used to convert a snapshot back into a regular variable. It serves as the opposite of the snapshot operator.
    - It enables the reuse of the old value without taking ownership or modifying the original variable.
- [`.unwrap()`](https://book.cairo-lang.org/ch09-02-recoverable-errors.html)
    - It attempts to extract the value of type T from a `Result<T, E>` when it is in the Ok variant. 
    - If the `Result` is `Ok(x)`, the method returns the value x. However, if the Result is in the `Err` variant, the `.unwrap()` method panics with a default error message, terminating the program execution. 
    - It is used when you are confident that the `Result` will be `Ok` and you want to directly access its value, but it should be used with caution due to its potential to cause a panic if the `Result` is `Err`.



# Starknet Foundry
- Starknet Foundry is a toolchain for developing Starknet smart contracts.
- It helps with writing, deploying, and testing starknet contracts.
- It is inspired by Foundry

## Install Starknet Foundry
1. Install Scarb: 
```bash
curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
```
Confirm scarb installation by running the command: 
```bash
scarb --version
```
2. Install the tool chain installer:
```bash
curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh | sh
```
3. Run the tool chain installer:
```bash
snfoundryup
```
Confirm Starknet Foundry installation by running:
```bash
sncast --version
```
or 
```bash
snforge --version
```

## Getting started with Starknet Foundry
- Start a new project using Starknet Foundry:
```bash
snforge init hello_starknet #project name
```
- Move into the project directory
```bash
cd hello_starknet
```
- Build project
```bash
scarb build
```
- Run tests
```
snforge test
```
> Uses `scarb` to build contracts first, then proceed to run tests using `snforge`
- Filter tests
```bash
snforge test test_increase_
```
- Run specific tests
```bash
snforge test hello_starknet::tests::test_increase_balance --exact
```

## Unit Tests
- Testing standalone functions in your smart contract
- Test functions should be in same file as functions being tested
- Must be in a module annonated with `#[cfg(test)]`
- `snforge` will collect tests only from these places:
    - any files reachable from the package root (declared as mod in lib.cairo or its children) - these have to be in a module annotated with #[cfg(test)]
    - files inside the tests directory
- [How tests are collected](https://foundry-rs.github.io/starknet-foundry/testing/test-collection.html)

## Integration Tests
- Testing the interaction of your contract with the blockchain state and other contracts.
- `@array![]` - Serializing the constructor with `Serde`.
- `SafeDispatcher` - Used when testing contract functions that can panic. It returns a `Result` instead of panicking.
```rust
let (contract_address, _) = contract.deploy(@array![]).unwrap();
```
>Returns the address of the deployed contract and the serialized return value of the constructor.

## Using Cheatcodes
- [Cheatcodes reference](https://foundry-rs.github.io/starknet-foundry/appendix/cheatcodes.html)
- When testing smart contracts, often there are parts of code that are dependent on a specific blockchain state. Instead of trying to replicate these conditions in tests, you can emulate them using **Cheatcodes**.
- By using cheatcodes, we can change various properties of transaction info, block info, etc.

### Some important cheatcodes
- `start_prank` - changes the caller address for contracts
- `CheatTarget` - enum for selecting contracts to target with cheatcodes
- `stop_prank` - cancels the prank / start_prank for contracts
- `CheatSpan` - enum for specifying the number of target calls for a cheat.
e.g
```
prank(CheatTarget::One(contract_address), new_caller_address, CheatSpan::TargetCalls(1))
```

### Cheatcode techinques
- `precalculate_address` - Precalculate the address of a contract before deployment. Used to prank the constructor when the caller/deployer address is needed inside the constructor.
```rust
use snforge_std::{ContractClassTrait}

// Precalculate the address to obtain the contract address before the constructor call (deploy) itself
let contract_address = contract.precalculate_address(constructor_arguments);
```

## Testing Events
- Using `assert_emitted`
    - Takes the array snapshot of tuples (ContractAddress, event) we expect were emitted
        - `spy.assert_emitted(@array![contract_address, event]...`
    - After the assertion, found events are removed from the spy. It stays clean and ready for the next events.
- Using `assert_not_emitted`
    - Works similarly as `assert_emitted` with the only difference that it panics if an event was emitted during the execution.
        - `spy.assert_not_emitted(@array![contract_address, event...`
    
    


## Resources
- [Universal Contract Deployer (UDC)](https://docs.openzeppelin.com/contracts-cairo/0.6.1/udc)
- Utilities - [Stark Utils app](https://stark-utils.vercel.app/converter), [Cairo Utils app](https://cairo-utils-web.vercel.app/)
- Using [`Result`](https://book.cairo-lang.org/ch09-02-recoverable-errors.html)