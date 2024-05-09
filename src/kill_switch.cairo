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

