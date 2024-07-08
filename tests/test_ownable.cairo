use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, start_prank, CheatTarget};
use hello_cairo::{ownable_contract::{IOwnableContractDispatcher, IOwnableContractDispatcherTrait},};

// Deploys the OwnerContract and returns its address.
fn deploy_contract() -> ContractAddress {
    // Declare the contract class.
    let contract_class = declare("OwnerContract").unwrap();

    // Construct constructor arguments.
    let constructor_calldata = array![Accounts::owner().into()];

    // Deploy the contract.
    let (contract_address, _) = contract_class.deploy(@constructor_calldata).unwrap();
    contract_address
}

// Test that address zero cannot call set new owner.
#[test]
#[should_panic(expected: 'Owner cannot be zero addr')]
fn test_new_owner_not_zero() {
    // Deploy the OwnerContract and store its address.
    let contract_address = deploy_contract();

    // Get the zero address.
    let address_zero = Accounts::zero();

    // Initialize the OwnableContract dispatcher with the contract address.
    let dispatcher = IOwnableContractDispatcher { contract_address };

    // Start a prank to simulate contract interactions from the zero address.
    start_prank(CheatTarget::One(contract_address), address_zero);

    // Attempt to set the owner to the zero address, which should cause a panic.
    dispatcher.set_owner(address_zero);
}

// Test that only the owner can call set new owner.
#[test]
#[should_panic(expected: 'Caller not owner')]
fn test_only_owner_can_set_new_owner() {
    // Deploy the OwnerContract and store its address.
    let contract_address = deploy_contract();

    // Get the address of a user who is not the owner.
    let user_one = Accounts::user_1();

    // Initialize the OwnableContract dispatcher with the contract address.
    let dispatcher = IOwnableContractDispatcher { contract_address };

    // Start a prank to simulate contract interactions from the non-owner address.
    start_prank(CheatTarget::One(contract_address), user_one);

    // Attempt to set the owner to user_one, which should cause a panic.
    dispatcher.set_owner(user_one);
}

// Test that the get_owner function returns the correct owner.
#[test]
fn test_get_owner() {
    // Deploy the OwnerContract and store its address.
    let contract_address = deploy_contract();

    // Get the address of the owner.
    let owner = Accounts::owner();

    // Initialize the OwnableContract dispatcher with the contract address.
    let dispatcher = IOwnableContractDispatcher { contract_address };

    // Retrieve the owner from the contract.
    let ownable_owner = dispatcher.get_owner();

    // Assert that the retrieved owner is the expected owner.
    assert_eq!(ownable_owner, owner);
}

// Test that the owner can set a new owner.
#[test]
fn test_set_new_owner() {
    // Deploy the OwnerContract and store its address.
    let contract_address = deploy_contract();

    // Get the address of the owner.
    let owner = Accounts::owner();

    // Get the address of the new owner.
    let new_owner = Accounts::user_1();

    // Start a prank to simulate contract interactions from the owner's address.
    start_prank(CheatTarget::One(contract_address), owner);

    // Initialize the OwnableContract dispatcher with the contract address.
    let dispatcher = IOwnableContractDispatcher { contract_address };

    // Set the new owner.
    dispatcher.set_owner(new_owner);

    // Retrieve the owner from the contract.
    let ownable_owner = dispatcher.get_owner();

    // Assert that the retrieved owner is the new owner.
    assert_eq!(ownable_owner, new_owner);
}

// Module containing account address utilities.
pub mod Accounts {
    use starknet::ContractAddress;
    use core::traits::TryInto;

    // Returns the address of the owner.
    pub fn owner() -> ContractAddress {
        'owner'.try_into().unwrap()
    }

    // Returns the address of user_1.
    pub fn user_1() -> ContractAddress {
        '1'.try_into().unwrap()
    }

    // Returns the address of user_2.
    pub fn user_2() -> ContractAddress {
        '2'.try_into().unwrap()
    }

    // Returns the zero address.
    pub fn zero() -> ContractAddress {
        0x0000000000000000000000000000000000000000.try_into().unwrap()
    }
}
