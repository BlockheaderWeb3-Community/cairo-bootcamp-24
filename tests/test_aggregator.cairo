use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, start_prank, CheatTarget};
use hello_cairo::{ 
    aggregator_contract::{IAggregatorDispatcher, IAggregatorDispatcherTrait},
    counter_contract::{ICounterDispatcher, ICounterDispatcherTrait},
    };

// Deploys contract and returns the address
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@array![]).unwrap();
    contract_address
}


fn deploy_contract_with_constructor() -> ContractAddress {
    // declare
    let contract_class = declare("OwnerContract").unwrap();
    // construct args
    let constructor_calldata = array![Accounts::owner().into()];
    // deploy
    let (contract_address, _) = contract_class.deploy(@constructor_calldata).unwrap();
    contract_address
}



#[test]
fn test_count_should_be_zero() {
    let contract_address = deploy_contract("aggregator");
    let aggregator_dispatcher = IAggregatorDispatcher { contract_address };
    let count = aggregator_dispatcher.get_aggr_count();
    assert_eq!(count, 0);
}

#[test]
// This test function verifies that the aggregated count increases by two.
fn test_should_increase_count_by_two() {
    // Deploy the aggregator contract and store its address.
    let contract_address = deploy_contract("aggregator");

    // Deploy the counter contract and store its address.
    let counter_contract_address = deploy_contract("CounterContract");

    // Initialize the counter dispatcher with the address of the counter contract.
    let counter_dispatcher = ICounterDispatcher {contract_address: counter_contract_address};

    // Request to increase the count in the counter contract by 2.
    counter_dispatcher.increase_count(2);

    // Deploy the kill switch contract and store its address.
    let kill_switch_contract_address = deploy_contract("KillSwitch");

    // Initialize the aggregator dispatcher with the address of the aggregator contract.
    let dispatcher = IAggregatorDispatcher { contract_address };

    // Request to increase the aggregated count by two using the counter and kill switch contracts.
    dispatcher.increase_aggr_count_by_two(counter_contract_address, kill_switch_contract_address);

    // Retrieve the current aggregated count from the aggregator.
    let count = dispatcher.get_aggr_count();

    // Assert that the aggregated count is equal to 2, as expected after the increase.
    assert_eq!(count, 2);
}


#[test]
fn test_should_retrieve_ownable_contract_owner() {
    // Retrieve the account owner's address.
    let owner = Accounts::owner();

    // Deploy the aggregator contract and store its address.
    let contract_address = deploy_contract("aggregator");

    // Initialize the aggregator dispatcher with the address of the aggregator contract.
    let aggregator_dispatcher = IAggregatorDispatcher { contract_address };

    // Start a prank to simulate contract interactions from the perspective of the owner.
    start_prank(CheatTarget::One(contract_address), owner);

    // Deploy an ownable contract and store its address, passing in constructor data if necessary.
    let ownable_contract_address = deploy_contract_with_constructor();

    // Fetch the owner address from the ownable contract using the aggregator dispatcher.
    let aggr_owner = aggregator_dispatcher.fetch_ownable_contract_owner(ownable_contract_address);

    // Assert that the fetched owner address matches the expected owner's address.
    assert_eq!(aggr_owner, owner);
}



// #[test]
// fn test_should_set_new_owner() {
//     // Retrieve the account owner's address.
//     let owner = Accounts::owner();

//     // Deploy the aggregator contract and store its address.
//     let contract_address = deploy_contract("aggregator");

//     // Initialize the aggregator dispatcher with the address of the aggregator contract.
//     let aggregator_dispatcher = IAggregatorDispatcher { contract_address };

//     // Start a prank to simulate contract interactions from the perspective of the owner.
//     start_prank(CheatTarget::One(contract_address), owner);

//     // Deploy an ownable contract and store its address, passing in constructor data if necessary.
//     let ownable_contract_address = deploy_contract_with_constructor();

//     // set the new owner from the ownable contract using the aggregator dispatcher.
//     aggregator_dispatcher.set_new_ownable_contract_owner(ownable_contract_address, owner);

//    // Fetch the owner address from the ownable contract using the aggregator dispatcher
//     let new_owner = aggregator_dispatcher.fetch_ownable_contract_owner(ownable_contract_address);

//     // Assert that the new owner address matches the expected owner's address.
//     assert_eq!(new_owner, owner);
// }



#[test]
fn test_kill_switch_status_should_return_false() {
    // Retrieve the account owner's address.
    let owner = Accounts::owner();
    
    // Deploy the aggregator contract and store its address.
    let contract_address = deploy_contract("aggregator");
    
    // Initialize the aggregator dispatcher with the address of the aggregator contract.
    let aggregator_dispatcher = IAggregatorDispatcher { contract_address };

    // Start a prank to simulate contract interactions from the perspective of the owner.
    start_prank(CheatTarget::One(contract_address), owner);
    
    // Deploy the KillSwitch contract and store its address.
    let kill_switch_contract_address = deploy_contract("KillSwitch");
    
    // Fetch the kill switch status from the aggregator dispatcher using the KillSwitch contract address.
    let kill_switch_status = aggregator_dispatcher.get_kill_switch_status(kill_switch_contract_address);

    // Assert that the fetched kill switch status matches the expected status (false).
    assert_eq!(kill_switch_status, false);
}



pub mod Accounts {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    pub fn owner() -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    pub fn user_1() -> ContractAddress {
        '1'.try_into().unwrap()
    }

    pub fn user_2() -> ContractAddress {
        '2'.try_into().unwrap()
    }

    pub fn zero() -> ContractAddress {
        0x0000000000000000000000000000000000000000.try_into().unwrap()
    }


}