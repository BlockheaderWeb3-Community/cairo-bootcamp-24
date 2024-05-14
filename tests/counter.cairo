use starknet::{ContractAddress};
use snforge_std::{declare, ContractClassTrait};
use testing_using_snforge::{
    counter::{
        ICounterDispatcher, ICounterDispatcherTrait, ICounterSafeDispatcher,
        ICounterSafeDispatcherTrait
    },
    errors::Errors
};

pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@ArrayTrait::new()).unwrap();
    contract_address
}

#[test]
// #[ignore]
#[feature("safe_dispatcher")]
fn test_default_count_value() {
    let contract_address = deploy_contract("CounterContract");
    let counter = ICounterSafeDispatcher { contract_address };
    let count_1 = counter.get_count().unwrap();
    assert(count_1 == 0, Errors::INVALID_COUNT_VALUE);
    assert_eq!(count_1, 0);
}

#[test]
#[feature("safe_dispatcher")]
fn test_cannot_increase_count_by_zero() {
    let contract_address = deploy_contract("CounterContract");
    let counter = ICounterSafeDispatcher { contract_address };
    match counter.increase_count(0) {
        Result::Ok(_) => core::panic_with_felt252('should have panicked'),
        Result::Err(panic_data) => {
            assert(*panic_data.at(0) == Errors::ZERO_AMOUNT, *panic_data.at(0));
        }
    }
}

#[test]
#[should_panic(expected: 'amount cannot be zero')]
fn test_cannot_increase_count_by_zero_with_panic() {
    let contract_address = deploy_contract("CounterContract");
    let counter = ICounterDispatcher { contract_address };
    counter.increase_count(0);
}
