
mod addition;
mod check_num;
mod long_str;
mod is_even;
mod typecast;

use addition::add_num;
use check_num::calculate;
use long_str::gm_long_str;
// use is_even::{is_sum_even, check_is_even };

fn main() {
    let is_even_result: bool = is_even::is_sum_even(2, 2);
    println!("is even result here___1: {}", is_even_result);
    // let converted_result: u16 = typecast::convert_u8_to_u16(10, 5);

    let converted_types_result: u32 = typecast::convert_types(255, 65535);
    println!("typecast sum to u32 {}", converted_types_result);
}

