use starknet::{ContractAddress, get_caller_address};
use snforge_std::{declare, ContractClassTrait};
use starknet_testing::counter_v2::{ICounterV2Dispatcher, ICounterV2DispatcherTrait};

// Custom account module
pub mod Accounts {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    // Generate and return account address from 'owner'
    pub fn owner() -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    // Generate and return account address from 'account1'
    pub fn account1() -> ContractAddress {
        'account1'.try_into().unwrap()
    }
}

// Deploy contract and return contract address
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let constructor_calldata = array![];
    let (contract_address, _) = contract.deploy(@constructor_calldata).unwrap();
    contract_address
}

#[test]
fn test_deploy_contract_v2() {
    // Deploy contract
    let contract_address = deploy_contract("CounterContractV2");

    // Get contract dispatcher
    let counter_v2_dispatcher = ICounterV2Dispatcher { contract_address };

    // Get 'owner' account address
    let custom_owner: ContractAddress = Accounts::owner();

    // Get 'owner' from contract storage. The value is set during contract deployment.
    // In the case of CounterContractV2, 'owner' is set using the caller address i.e deployer, 
    // which is the address of Universal Contract Deployer (UDC).
    // This is not the intention as we want the contract owner to be an account we have access to. CounterContracrtV3 fixes this problem
    let contract_owner = counter_v2_dispatcher.get_owner();

    println!("custom owner: {:?}", custom_owner);
    println!("contract owner: {:?}", contract_owner);

    //  Assert that contract_owner and custom owner addresses are not equal
    // `contract_owner` in this case is the UDC address, while `custom_owner` is the address of 'owner' custom account we created earlier
    assert_ne!(contract_owner, custom_owner);
}
