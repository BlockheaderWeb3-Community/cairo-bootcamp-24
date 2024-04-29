// function to perform basic subtraction arithmetic operation
pub fn sub_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 - n2;
    return result;
}

// function to perform basic multiplication arithmetic operation
pub fn mul_num(n1: u16, n2: u16) -> u16 {
    let result: u16 = n1 * n2;
    result
}

// function to perform basic division arithmetic operation
pub fn div_num(n1: u16, n2: u16) -> u16 {
    if n2 == 0 {
        println!("\tZeroDivisionError Not allowed!");
        return 0;
    }
    let result = (n1 / n2);
    println!("The division of {} by {} equal {}", n1, n2, result);
    result
}

