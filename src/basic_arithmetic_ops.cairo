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
// Panics when attempt to divide by zero
pub fn div_num(n1: u16, n2: u16) -> u16 {
    if n2 == 0 {
        // println!("\tZeroDivisionError Not allowed!");
        panic!("ZeroDivisionError Not allowed!");
    // return 0;
    }
    let result = (n1 / n2);
    println!("The division of {} by {} equal {}", n1, n2, result);
    result
}

#[cfg(test)]
mod tests {
    use super::{sub_num, mul_num, div_num};

    // using assert!() 
    #[test]
    fn test_sub_num() {
        let x = 8;
        let y = 6;
        let result = sub_num(x, y);
        assert!(result == 2, "sub not working!");
    }

    // using assert_eq!(), assert_ne!(), assert_gt!(), assert_lt!()
    #[test]
    fn test_mul_num() {
        let x = 8;
        let y = 2;
        let result = mul_num(x, y);
        assert_eq!(16, result);
        assert_ne!(17, result);
        assert_gt!(17, result);
        assert_lt!(15, result);
    }

    #[test]
    fn test_div_num() {
        let result = div_num(10, 2);
        assert_eq!(5, result);
    }

    // using #[should_panic]
    #[test]
    #[should_panic]
    fn test_div_num_should_panic() {
        let _ = div_num(10, 0); // division by zero
    }

    // using #[should_panic(expected)]
    #[test]
    #[should_panic(expected: ("ZeroDivisionError Not allowed!", ))]
    fn test_div_num_should_panic_with_expected() {
        let _ = div_num(10, 0); // division by zero
    }

    // using #[available_gas()]
    #[test]
    #[available_gas(1000000)] // remove 1 zero to see this test fail
    fn test_div_with_available_gas() {
        let result = div_num(100, 5);
        assert_eq!(20, result);
    }
}
