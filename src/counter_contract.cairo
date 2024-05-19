#[starknet::interface]
pub trait ICounter<TContractState> {
    fn increase_count(ref self: TContractState, amount: u32);
    fn get_count(self: @TContractState) -> u32;
}

#[starknet::contract]
mod CounterContract {
    #[storage]
    struct Storage {
        count: u32,
    }

    #[abi(embed_v0)]
    impl ICounterImpl of super::ICounter<ContractState> {
        fn increase_count(ref self: ContractState, amount: u32) {
            assert(amount != 0, hello_cairo::errors::Errors::ZERO_AMOUNT);
            let current_count: u32 = self.count.read();
            let result = hello_cairo::addition::add_num(current_count, amount);
            self.count.write(result);
        }

        fn get_count(self: @ContractState) -> u32 {
            self.count.read()
        }
    }
}
// 0x5afdb452821d219d5b8bc68a44ca3c6fa4dfc313150d30d093a279c090d69e3 - counter_contract_addr


