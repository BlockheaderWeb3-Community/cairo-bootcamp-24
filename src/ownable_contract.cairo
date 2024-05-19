use starknet::{get_caller_address, ContractAddress};

#[starknet::interface]
pub trait IOwnableContract<T> {
    fn set_owner(ref self: T, new_owner: ContractAddress);
    fn get_owner(self: @T) -> ContractAddress;
}


#[starknet::contract]
mod OwnerContract {
    use core::num::traits::zero::Zero;
    use starknet::{get_caller_address, ContractAddress};
    use super::IOwnableContract;

    #[storage]
    struct Storage {
        owner: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState, init_owner: ContractAddress) {
        assert(!init_owner.is_zero(), hello_cairo::errors::Errors::ZERO_ADDRESS_CALLER);
        self.owner.write(init_owner);
    }

    #[abi(embed_v0)]
    impl OwnerContractImpl of IOwnableContract<ContractState> {
        fn set_owner(ref self: ContractState, new_owner: ContractAddress) {
            assert(!new_owner.is_zero(), hello_cairo::errors::Errors::ZERO_ADDRESS_OWNER);
            let caller = get_caller_address();
            assert(caller == self.owner.read(), hello_cairo::errors::Errors::NOT_OWNER);
            self.owner.write(caller);
        }

        fn get_owner(self: @ContractState) -> ContractAddress {
            self.owner.read()
        }
    }
}
//  0x10643c1ad9f6effd8af79b32163977e803db69aae21444005044aeea85efc52 - ownable_contract_address


