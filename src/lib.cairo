fn main() {
    short_str();
    let result = check_num(30);
    println!("check_sum fn result here: {result}");
    let sum: u16 = add_num(10, 5);
    println!("the sum of 2 numbers is: {sum}");
    let sum: u16 = add_num(5, 3);
    println!("The sum of 5 and 3 equal {}", sum);
    let sub: u16 = sub_num(2, 1);
    println!("The subtraction of 2 and 1 equal {}", sub);
    let mul_val: u16 = mul_num(2, 2);
    println!("The multiplication of 2 and 2 equal {}", mul_val);
    let div_val: u16 = div_num(10, 0);
    println!("The division of 10 and 2 equal {}", div_val);
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

// function to perform basic subtraction arithmetic operation
fn sub_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 - n2;
    result
}

// function to perform basic multication arithmetic operation
fn mul_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 * n2;
    result
}

// function to perform basic division arithmetic operation
fn div_num(n1: u16, n2: u16) -> u16 {
    if n2 == 0 {
        println!("\tZeroDivisionError Not allowed!");
        return 0;
    }
    (n1 / n2)
}
