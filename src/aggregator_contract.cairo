use starknet::ContractAddress;

#[starknet::interface]
pub trait IAggregator<TContractState> {
    fn get_kill_switch_status(
        self: @TContractState, kill_switch_contract_address: ContractAddress
    ) -> bool;

    fn fetch_ownable_contract_owner(
        self: @TContractState, ownable_contract_address: ContractAddress
    ) -> ContractAddress;

    fn set_new_ownable_contract_owner(
        ref self: TContractState,
        ownable_contract_address: ContractAddress,
        new_owner: ContractAddress
    );

    fn increase_aggr_count_by_two(
        ref self: TContractState,
        counter_contract_adress: ContractAddress,
        kill_switch_contract_address: ContractAddress
    );

    fn get_aggr_count(self: @TContractState) -> u32;
}


#[starknet::contract]
pub mod aggregator {
    use hello_cairo::aggregator_contract::IAggregator;
    use starknet::ContractAddress;
    use core::num::traits::zero::Zero;
    use hello_cairo::{
        ownable_contract::{IOwnableContractDispatcher, IOwnableContractDispatcherTrait},
        counter_contract::{ICounterDispatcher, ICounterDispatcherTrait},
        kill_switch::{IKillSwitchDispatcher, IKillSwitchDispatcherTrait}
    };

    #[storage]
    struct Storage {
        aggr_count: u32
    }


    #[abi(embed_v0)]
    impl AggregatorImpl of super::IAggregator<ContractState> {
        fn fetch_ownable_contract_owner(
            self: @ContractState, ownable_contract_address: ContractAddress
        ) -> ContractAddress {
            // here we are passing the contract address of OwnerContract contract into
            // IOwnableDispatcher then we call the get owner function
            IOwnableContractDispatcher { contract_address: ownable_contract_address }.get_owner()
        }

        fn get_kill_switch_status(
            self: @ContractState, kill_switch_contract_address: ContractAddress
        ) -> bool {
            IKillSwitchDispatcher { contract_address: kill_switch_contract_address }.is_active()
        }

        fn set_new_ownable_contract_owner(
            ref self: ContractState,
            ownable_contract_address: ContractAddress,
            new_owner: ContractAddress
        ) {
            assert(new_owner.is_non_zero(), hello_cairo::errors::Errors::ZERO_ADDRESS_OWNER);
            IOwnableContractDispatcher { contract_address: ownable_contract_address }
                .set_owner(new_owner);
        }

        fn increase_aggr_count_by_two(
            ref self: ContractState,
            counter_contract_adress: ContractAddress,
            kill_switch_contract_address: ContractAddress
        ) {
            IKillSwitchDispatcher { contract_address: kill_switch_contract_address }.activate();

            let kill_switch_status = IKillSwitchDispatcher {
                contract_address: kill_switch_contract_address
            }
                .is_active();
            assert(kill_switch_status == true, hello_cairo::errors::Errors::NOT_ACTIVE);
            let current_aggr_count = self.aggr_count.read();
            let current_count = ICounterDispatcher { contract_address: counter_contract_adress }
                .get_count();
            self.aggr_count.write(current_aggr_count + current_count);

            IKillSwitchDispatcher { contract_address: kill_switch_contract_address }.deactivate();
        }

        fn get_aggr_count(self: @ContractState) -> u32 {
            self.aggr_count.read()
        }
    }
}

