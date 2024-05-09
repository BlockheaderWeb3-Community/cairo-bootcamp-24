fn main() {
    short_str();
    let result = check_num(30);
    println!("result here: {result}");
    let sum: u16 = add_num(10, 5);
    println!("sum here: {sum}");
    let sub: u32 = sub_num(8, 53);
    println!("subtraction of two numbers is: {sub}");
    let mul: u64 = multiply_num(4, 6);
    println!("multiplying two numbers gives us: {mul}");
    let div: u16 = divide_nums(2, 12);
    println!("dividing two numbers gives us: {div}");
}

// short string data-type
fn short_str() {
    println!("GM Cairo!");
}

// bool data type
fn check_num(n1: u8) -> bool {
    if n1 > 20 {
        return true;
    }
    return false;
}

//  function to perform addition arithmetic operation
fn add_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 + n2;
    result
}

//  subtract function
fn sub_num(n1: u32, n2: u32) -> u32 {
    let result: u32 = n2 - n1;
    result
}

//  multiply function
fn multiply_num(n1: u64, n2: u64) -> u64 {
    let result: u64 = n1 * n2;
    result
}

//  divide function
fn divide_nums(n1: u16, n2: u16) -> u16 {
    let result: u16 = n2 / n1;
    result
}