fn main() {
    short_str();
    let result = check_num(30);
    println!("Check_sum function result here: {result}");
    let sum: u16 = add_num(20, 4);
    println!("The sum of two numbers is: {sum}");
    let diff: u16 = sub_num(12, 3);
    println!("The difference of 12 and 3 is: {}", sub);
    let mul_val: u16 = mul_num(4, 5);
    println!("The product of 4 and 5 equals {}", mul_val);
    let div_val: u16 = div_num(12, 2);
    println!("The division of 12 and 2 equals {}", div_val);
}

// Short string data type
fn short_str() {
    println!("Good morning, Cairo!");
}

// Boolean data type
fn check_num(n1: u8) -> bool {
    if n1 > 20 {
        return true;
    }
    return false;
}

// Function to perform basic addition arithmetic operation
fn add_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 + n2;
    return result;
}

// Function to perform basic subtraction arithmetic operation
fn sub_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 - n2;
    result
}

// Function to perform basic multiplication arithmetic operation
fn mul_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 * n2;
    result
}

// Function to perform basic division arithmetic operation
fn div_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = (n1 / n2)
    }
    
}


