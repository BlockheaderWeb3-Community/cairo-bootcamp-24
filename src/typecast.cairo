use core::traits::Into;

// perform arithmetic operation to convert from u8 to u16
pub fn convert_u8_to_u16(num1: u8, num2: u8) -> u16 {
    let result: u16 = num1.into() + num2.into();
    result
}

// perform arithmetic operation of integers of different types
pub fn convert_types(num1: u8, num2: u16) -> u32 {
    let result: u32 = num1.into() + num2.into();
    result
}