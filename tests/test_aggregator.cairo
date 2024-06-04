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
fn test_should_increase_count_by_two() {
    // Deploy contract
    let contract_address = deploy_contract("aggregator");
    // Deploy counter contract
    let counter_contract_address = deploy_contract("CounterContract");

    let counter_dispatcher = ICounterDispatcher {contract_address: counter_contract_address};
    // increase counter contract by2
    counter_dispatcher.increase_count(2);
    // Deploy kill switch contract
    let kill_switch_contract_address = deploy_contract("KillSwitch");
    // Get contract dispatcher
    let dispatcher = IAggregatorDispatcher { contract_address };
    // increase count by two
    dispatcher.increase_aggr_count_by_two(counter_contract_address, kill_switch_contract_address);
    // Get current count
    let count = dispatcher.get_aggr_count();
    println!("count____{:?}__", count);

    assert_eq!(count, 2);

}



#[test]
fn test_should_retrieve_ownable_contract_owner() {
    let owner = Accounts::owner();
    //Deploy aggregator contract
    let contract_address = deploy_contract("aggregator");

    let aggregator_dispatcher = IAggregatorDispatcher { contract_address };

    start_prank(CheatTarget::One(contract_address), owner);
    // Deploy ownable contract with contrustor data
    let ownable_contract_address = deploy_contract_with_constructor();
    // fetch ownable contract owner
    let aggr_owner = aggregator_dispatcher.fetch_ownable_contract_owner(ownable_contract_address);
    // assert that ownable contract owner is same as owner
    assert_eq!(aggr_owner, owner);
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