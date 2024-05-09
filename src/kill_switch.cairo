#[starknet::interface]
pub trait IKillSwitch<TContractState> {
    fn is_active(self: @TContractState) -> bool;
    fn activate(ref self: TContractState); // this turns the is_active variable to true
    fn deactivate(ref self: TContractState); // this turns the is_active variable to false
}

#[starknet::contract]
mod KillSwitch {
    use super::IKillSwitch;

    #[storage]
    struct Storage {
        is_active: bool,
    }

    #[constructor]
    fn constructor(ref self: ContractState, is_active: bool) {
        self.is_active.write(is_active);
    }

    #[abi(embed_v0)]
    impl KillSwitchImpl of IKillSwitch<ContractState> {
        fn is_active(self: @ContractState) -> bool {
            self.is_active.read()
        }

        fn activate(ref self: ContractState) {
            let is_active = true;
            self.is_active.write(is_active);
        }

        fn deactivate(ref self: ContractState) {
            let is_active = false;
            self.is_active.write(is_active);
        }
    }
}
// contract_address: 0x79726f3398723beff97c741f0ac68055f5ef037724a37dbed4a1ed24db24d7b
// txn_hash: 0x22912d9d15d186854ac48a490ab85566837d9b86c88ce34f69112ab6f065560


