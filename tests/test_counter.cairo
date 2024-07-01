use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, start_prank, CheatTarget};
use hello_cairo::{ 
    counter_contract::{ICounterDispatcher, ICounterDispatcherTrait},
    };

// Deploys contract and returns the address
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@array![]).unwrap();
    contract_address
}


#[test]
// Test the increase_count function
fn test_should_increase_count_by_two() {
    // Deploy the counter contract and store its address.
    let counter_contract_address = deploy_contract("CounterContract");
    
    // Initialize the counter dispatcher with the address of the counter contract.
    let counter_dispatcher = ICounterDispatcher { contract_address: counter_contract_address };
    
    // Increase the count in the counter contract by 2.
    counter_dispatcher.increase_count(2);
    
    // Retrieve the current count from the counter contract.
    let count = counter_dispatcher.get_count();
    
    // Assert that the count is equal to 2, as expected after the increase.
    assert_eq!(count, 2);
}



#[test]
#[should_panic(expected: ('amount cannot be zero',))]
fn test_amount_can_not_be_zero() {
    // Deploy the counter contract and store its address.
    let counter_contract_address = deploy_contract("CounterContract");
    // Initialize the counter dispatcher with the address of the counter contract.
    let counter_dispatcher = ICounterDispatcher { contract_address: counter_contract_address };
    // Attempt to increase the count in the counter contract by 0, which should cause a panic.
    counter_dispatcher.increase_count(0);
}

