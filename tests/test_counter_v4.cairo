
use starknet::{ContractAddress, get_caller_address};
use core::result::ResultTrait;
use snforge_std::{declare, ContractClassTrait, CheatTarget};
use snforge_std as snf;
use snforge_std::errors::{ SyscallResultStringErrorTrait, PanicDataOrString };
use starknet_testing::counter_v4::{ICounterV4Dispatcher, ICounterV4DispatcherTrait};

pub mod Accounts {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    pub fn owner() -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    pub fn account1() -> ContractAddress {
        'account1'.try_into().unwrap()
    }
}

// Deploy contract and return the contract address
pub fn deploy_contract_v4(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    // The constructor in CounterContractV3 expects one argument - the address to be set as `owner`
    let constructor_calldata = array![Accounts::owner().into()];
    let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
    contract_address
}

// Cannot increase count with other account
#[test]
fn test_deploy_contract_v4() {
    let contract_address = deploy_contract_v4("CounterContractV4");

    let counter_v4_dispatcher = ICounterV4Dispatcher { contract_address };

    let custom_owner: ContractAddress = Accounts::owner();

    let contract_owner = counter_v4_dispatcher.get_owner();

    assert_eq!(contract_owner, custom_owner);
}



#[test]
fn test_cannot_increase_count_account () {
    
    let contract_address = deploy_contract_v4("CounterContractV4");

    let counter_v4_dispatcher = ICounterV4Dispatcher { contract_address };

    let custom_owner: ContractAddress = Accounts::account1();

    let contract_owner = counter_v4_dispatcher.get_owner();

    assert!(contract_owner != custom_owner, "Cannot increase count with other account");

}


#[test]
fn test_owner_increase_count () {
    
    let contract_address = deploy_contract_v4("CounterContractV4");

    snf::start_prank(CheatTarget::One(contract_address), Accounts::owner());

    let counter_v4_dispatcher = ICounterV4Dispatcher { contract_address };

    counter_v4_dispatcher.increase_count(5);

    let get_owner_count = counter_v4_dispatcher.get_count();

    assert!(get_owner_count != 5, "Fail to update owner count");

    snf::stop_prank(CheatTarget::One(contract_address));

}



#[test]
#[feature("safe_dispatcher")]
fn test_cannot_increase_count_by_Zero() {
    let contract_address = deploy_contract_v4("CounterContractV4");

    let safe_dispatcher = ICounterV4Dispatcher { contract_address };

    match safe_dispatcher.increase_count(0) {
        Result::Ok(_) => core::panic_with_felt252('Should have panicked'),
        Result::Err(panic_data) => {
            assert(*panic_data.at(0) == 'Count cannot be 0', *panic_data.at(0));
        }
    };

}