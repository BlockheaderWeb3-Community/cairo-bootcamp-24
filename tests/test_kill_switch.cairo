use starknet::ContractAddress;
use snforge_std::{declare, ContractClassTrait, start_prank, CheatTarget};
use hello_cairo::{kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait}};

// Deploys the contract and returns its address.
pub fn deploy_contract(name: ByteArray) -> ContractAddress {
    let contract = declare(name).unwrap();
    let (contract_address, _) = contract.deploy(@array![]).unwrap();
    contract_address
}

#[test]
// Test the is_active function
fn test_kill_switch_is_active() {
    // Deploy the KillSwitch contract and store its address.
    let kill_switch_contract_address = deploy_contract("KillSwitch");

    // Initialize the KillSwitch dispatcher with the address of the KillSwitch contract.
    let kill_switch_dispatcher = IKillSwitchDispatcher {
        contract_address: kill_switch_contract_address
    };

    // Check the initial status of the KillSwitch, which should be inactive.
    let kill_switch_status = kill_switch_dispatcher.is_active();

    // Assert that the KillSwitch status is inactive initially.
    assert_eq!(kill_switch_status, false);
}

#[test]
// Test the activate function
fn test_activate_kill_switch() {
    // Deploy the KillSwitch contract and store its address.
    let kill_switch_contract_address = deploy_contract("KillSwitch");

    // Initialize the KillSwitch dispatcher with the address of the KillSwitch contract.
    let kill_switch_dispatcher = IKillSwitchDispatcher {
        contract_address: kill_switch_contract_address
    };

    // Check the initial status of the KillSwitch, which should be inactive.
    let deactivated_kill_switch_status = kill_switch_dispatcher.is_active();
    assert_eq!(deactivated_kill_switch_status, false);

    // Activate the KillSwitch.
    kill_switch_dispatcher.activate();

    // Check the status of the KillSwitch after activation, which should be active.
    let activated_kill_switch_status = kill_switch_dispatcher.is_active();

    // Assert that the KillSwitch status is active after activation.
    assert_eq!(activated_kill_switch_status, true);
}

#[test]
// Test the deactivate function
fn test_deactivate_kill_switch() {
    // Deploy the KillSwitch contract and store its address.
    let kill_switch_contract_address = deploy_contract("KillSwitch");

    // Initialize the KillSwitch dispatcher with the address of the KillSwitch contract.
    let kill_switch_dispatcher = IKillSwitchDispatcher {
        contract_address: kill_switch_contract_address
    };

    // Activate the KillSwitch to ensure it starts in an active state.
    kill_switch_dispatcher.activate();

    // Check the status of the KillSwitch after activation, which should be active.
    let activated_kill_switch_status = kill_switch_dispatcher.is_active();
    assert_eq!(activated_kill_switch_status, true);

    // Deactivate the KillSwitch.
    kill_switch_dispatcher.deactivate();

    // Check the status of the KillSwitch after deactivation, which should be inactive.
    let deactivated_kill_switch_status = kill_switch_dispatcher.is_active();

    // Assert that the KillSwitch status is inactive after deactivation.
    assert_eq!(deactivated_kill_switch_status, false);
}
