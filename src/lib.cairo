fn main() {
    // declare variables to be passed as argument to the functions
    let num1: u16 = 5;
    let num2: u16 = 3;
    let num3: u16 = 0;

    // functions calls
    short_str();
    let result = check_num(30);
    println!("check_sum fn result here: {result}");
    
    // sum call
    let sum: u16 = add_num(num1, num2);
    println!("The sum of {} and {} equal {}",num1, num2, sum);

    // subtraction call
    let sub: u16 = sub_num(num1, num2);
    println!("The subtraction of {} and {} equal {}", num1, num2, sub);

    // multiplication call
    let mul_val: u16 = mul_num(num1, num2);
    println!("The multiplication of {} and {} equal {}",num1, num2, mul_val);

    // division call
    let div_val: u16 = div_num(num1, num3);

    if div_val == 0 {
        println!("\tKindly input a non zero divisor.");
    } else {
        println!("The division of {} and {} equal {}", num1, num3, div_val);
    }
    
    let div_val: u16 = div_num(num1, num2);
    if div_val == 0 {
        println!("\tKindly input a non zero divisor.");
    } else {
        println!("The division of {} and {} equal {}", num1, num2, div_val);
    }

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
