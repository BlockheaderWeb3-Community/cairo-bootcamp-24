
mod addition;
mod check_num;
mod long_str;
mod is_even;

use addition::add_num;
use check_num::calculate;
use long_str::gm_long_str;
// use is_even::{is_sum_even, check_is_even };

fn main() {
    let is_even_result: bool = is_even::is_sum_even(2, 2);
    println!("is even result here___1: {}", is_even_result);
    println!("is even result here___2: {is_even_result}");
}

