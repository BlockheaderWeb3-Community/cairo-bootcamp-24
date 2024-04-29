fn main() {
    short_str();
    let result = check_num(30);
    println!("check_sum fn result here: {result}");
    let sum: u16 = add_num(10, 5);
    println!("the sum of 2 numbers is: {sum}");
    let sub: u16 = sub_num(20, 16);
    println!("the substraction of 2 numbers is: {sub}");
    let multiply: u16 = multiply_num(4, 25);
    println!("the multiplcation of 2 numbers is: {multiply}");
    let division: u16 = division_num(16, 4);
    println!("the division of 2 numbers is: {division}");
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

fn sub_num(num1: u16, num2: u16) -> u16 {
    let sub = num1 - num2;
    return sub;
}

fn multiply_num(num1: u16, num2: u16) -> u16 {
    let multiply = num1 * num2;
    return multiply;
}

fn division_num(num1: u16, num2: u16) -> u16 {
    if num1 == 0 {
        println!("num1 cannot be zero");
    }
    if num2 == 0 {
        println!("num2 cannot be zero");
    }
    let division = num1 / num2;

    return division;
}
