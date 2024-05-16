use starknet::{ContractAddress, get_caller_address};

#[starknet::interface]
pub trait ICounterV3<TContractState> {
    fn increase_count(ref self: TContractState, amount: u32);
    fn get_count(self: @TContractState) -> u32;
    fn get_owner(self: @TContractState) -> ContractAddress;
}

#[starknet::contract]
pub mod CounterContractV3 {
    use starknet_testing::errors::Errors;
    use starknet_testing::add::add;
    use super::{ContractAddress, get_caller_address};

    #[storage]
    struct Storage {
        count: u32,
        owner: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, _owner: ContractAddress) {
        // Set `owner` address 
        self.owner.write(_owner);
    }

    #[abi(embed_v0)]
    impl ICounterImpl of super::ICounterV3<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            let caller = get_caller_address();
            assert(caller == self.owner.read(), 'not owner');
            assert(amount != 0, Errors::ZERO_AMOUNT);
            let current_count: u32 = self.count.read();
            let result = add(current_count, amount);
            self.count.write(result);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }

        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
    }
}
