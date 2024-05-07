pub mod Errors {
    pub const ZERO_AMOUNT: felt252 = 'amount cannot be zero';
    pub const ZERO_ADDRESS_CALLER: felt252 = 'Caller cannot be zero addr';
    pub const ZERO_ADDRESS_OWNER: felt252 = 'Owner cannot be zero addr';
    pub const NOT_OWNER: felt252 = 'Caller not owner';
}
