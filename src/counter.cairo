#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increase_count(ref self: TContractState, amount: u32);
    fn get_count(self: @TContractState) -> u32;
}

#[starknet::contract]
pub mod CounterContract {
    use starknet_testing::errors::Errors;
    use starknet_testing::add::add;

    #[storage]
    struct Storage {
        count: u32,
    }

    #[abi(embed_v0)]
    impl ICounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            assert(amount != 0, Errors::ZERO_AMOUNT);
            let current_count: u32 = self.count.read();
            let result = add(current_count, amount);
            self.count.write(result);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
