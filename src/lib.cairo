fn main() {
    short_str();
    let result = check_num(30);
    println!("check_sum fn result here: {result}");
    let sum: u16 = add_num(10, 5);
    println!("the sum of 2 numbers is: {sum}");
}

// short string data type
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

// function to perform basic addition arithmetic operation
fn add_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 + n2;
    return result;
}

