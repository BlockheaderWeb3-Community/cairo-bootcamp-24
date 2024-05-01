mod addition;
mod check_num;
mod long_str;
mod is_even;
mod typecast;
mod basic_arithmetic_ops;

use addition::add_num;
use check_num::calculate;
use long_str::gm_long_str;
use basic_arithmetic_ops::{sub_num, mul_num, div_num};
// use is_even::{is_sum_even, check_is_even };

fn main() {
    let is_even_result: bool = is_even::is_sum_even(2, 2);
    println!("is even result here___1: {}", is_even_result);
    // let converted_result: u16 = typecast::convert_u8_to_u16(10, 5);

    let converted_types_result: u32 = typecast::convert_types(255, 65535);
    println!("typecast sum to u32 {}", converted_types_result);

    // declare variables to be passed as argument to the functions
    let num1: u16 = 5;
    let num2: u16 = 3;
    let num3: u16 = 0;

    // add_num call
    let sum_result: u16 = add_num(num1, num2);
    println!("The addition of {} and {} equal {}", num1, num2, sum_result);

    // sub_num call
    let sub_result: u16 = sub_num(num1, num2);
    println!("The difference between {} and {} equal {}", num1, num2, sub_result);

    // mul_num call
    let prod_result: u16 = mul_num(num1, num2);
    println!("The product of {} and {} equal {}", num1, num2, prod_result);

    // div_num call
    let _div_result: u16 = div_num(num1, num2);
    let _div_result2: u16 = div_num(num1, num3);
}

