#[starknet::contract]
pub mod AggregatorContract {
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


    #[generate_trait]
    // #[abi(embed_v0)]
    #[external(v0)]
    impl AggregatorImpl of IAggregator {
        fn fetch_ownable_contract_owner(
            self: @ContractState, ownable_contract_address: ContractAddress
        ) -> ContractAddress {
            // here we are passing the contract address of OwnerContract contract into  IOwnableDispatcher
            // then we call the get owner function
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
            let kill_switch_status = IKillSwitchDispatcher {
                contract_address: kill_switch_contract_address
            }
                .is_active();
            assert(kill_switch_status == true, hello_cairo::errors::Errors::NOT_ACTIVE);
            let current_count = ICounterDispatcher { contract_address: counter_contract_adress }
                .get_count();
            self.aggr_count.write(current_count * 2);
        }

        fn get_aggr_count(self: @ContractState) -> u32 {
            self.aggr_count.read()
        }
    }
}
// 0x1b963d5bcc6bcacd3fdd0d2fec50a6e4ac8b150a74ef2221a4b3622ffe94ec3

// contract_address: 0x40c9ed24c04827ed76045aa218b56bc85688a92b7be17e8ec4745106846269c
// txn_hash: 0x6a5c8190770e3666eb7a81ded11461096fac078b0ac754e4c3efa68b427be7d


