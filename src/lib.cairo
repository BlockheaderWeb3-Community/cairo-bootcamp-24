fn main() {
    short_str();
    let result = check_num(30);
    println!("Check_sum function result here: {}", result); // Fixed the string interpolation syntax
    let sum: u16 = add_num(20, 4);
    println!("The sum is: {}", sum); // Fixed the string interpolation syntax
    let diff: u16 = sub_num(12, 3);
    println!("The difference is: {}", diff); // Fixed variable name mismatch in string interpolation
    let mul_val: u16 = mul_num(4, 5);
    println!("The product is {}", mul_val);
    let div_val: u16 = div_num(12, 2);
    println!("The result is {}", div_val);
}

// Short string data type
fn short_str() {
    println!("Good morning, Cairo!");
}

// Boolean data type
fn check_num(n1: u8) -> bool {
    n1 > 20 // Simplified boolean return
}

// Function to perform basic addition arithmetic operation
fn add_num(n1: u16, n2: u16) -> u16 {
    n1 + n2 // Simplified return
}

// Function to perform basic subtraction arithmetic operation
fn sub_num(n1: u16, n2: u16) -> u16 {
    n1 - n2 // Simplified return
}

// Function to perform basic multiplication arithmetic operation
fn mul_num(n1: u16, n2: u16) -> u16 {
    n1 * n2 // Simplified return
}

// Function to perform basic division arithmetic operation
fn div_num(n1: u16, n2: u16) -> u16 {
    n1 / n2 // Corrected syntax and simplified return
}
