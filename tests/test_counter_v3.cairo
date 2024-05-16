use starknet::{ContractAddress, get_caller_address};
use snforge_std::{declare, ContractClassTrait};
use starknet_testing::counter_v3::{ICounterV3Dispatcher, ICounterV3DispatcherTrait};

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
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    // The constructor in CounterContractV3 expects one argument - the address to be set as `owner`
    let constructor_calldata = array![Accounts::owner().into()];
    let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
    contract_address
}

#[test]
fn test_deploy_contract_v3() {
    let contract_address = deploy_contract("CounterContractV3");

    let counter_v3_dispatcher = ICounterV3Dispatcher { contract_address };

    let custom_owner: ContractAddress = Accounts::owner();

    let contract_owner = counter_v3_dispatcher.get_owner();
    println!("custom owner: {:?}", custom_owner);
    println!("contract owner: {:?}", contract_owner);
    
    assert_eq!(contract_owner, custom_owner);
}
