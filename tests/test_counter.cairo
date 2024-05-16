use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait};
use starknet_testing::counter::{ICounterDispatcher, ICounterDispatcherTrait};

// Deploys contract and returns the address
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@array![]).unwrap();
    contract_address
}


#[test]
#[should_panic(expected: 'zero amount')]
fn test_cannot_increase_count_by_zero() {
    // Deploy contract
    let contract_address = deploy_contract("CounterContract");

    // Print contract address
    println!("contract address: {:?}", contract_address);

    // Get contract dispatcher
    let counter_dispatcher = ICounterDispatcher { contract_address };

    // Invoke a state changing function in the contract
    // This is expected to panic because the function does not accept zero
    // The panic error has been handled using `should_panic` attribute before the test function name
    counter_dispatcher.increase_count(0);
}

#[test]
fn test_can_increase_count() {
    // Deploy contract
    let contract_address = deploy_contract("CounterContract");

    // Get contract dispatcher
    let counter_dispatcher = ICounterDispatcher { contract_address };

    // Get initial count value and assert
    let initial_count = counter_dispatcher.get_count();
    assert_eq!(initial_count, 0);

    // Invoke `increase_count` function to increase value of count
    counter_dispatcher.increase_count(5);

    // Get current count value and assert
    let current_count = counter_dispatcher.get_count();
    assert_eq!(current_count, 5);
    assert_ne!(current_count, 10);
}
