fn main() {
    short_str();
    let result = check_num(30);
    println!("check_sum fn result here: {result}");
    let sum: u16 = add_num(10, 5);
    println!("the sum of 2 numbers is: {sum}");
    let mult: u32 = multiply_num(10, 10);
    println!("the multiplication of two numbers is: {mult}");
    let substr: u16 = substr_num(30, 18);
    println!("the substraction of two numbers is: {substr}");
    let div: u16 = div_num(20, 4);
    println!("the division of two numbers is: {div}");
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

// This function multiplies two numbers 
fn multiply_num(a: u16, u16 b) -> u32 {
    let result: u32 = a * b;
    //returns the result of the multiplied numbers
    return result;
}

//This function performs substraction
fn substr_num(u16: n1, u16: n2) -> u16 {
    let result: u16 = n1 - n2;
    //implicit return:
    result
}

//This function performs divition
fn div_num(u16: n1, u16 n2) -> u16{
    let result: u16 = n1/n2;
    //implicit return:
    result
}

