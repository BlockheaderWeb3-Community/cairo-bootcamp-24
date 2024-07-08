pub fn add_num(num1: u32, num2: u32) -> u32 {
    num1 + num2
}


#[cfg(test)]
mod tests {
    #[test]
    #[ignore]
    fn test_add_num() {
        let sum_result = super::add_num(2, 3);
        assert_eq!(sum_result, 5);
    }


    #[test]
    #[should_panic(expected: 'u32_add Overflow')]
    fn test_add_num_should_panic() {
        super::add_num(4294967295, 3);
    }
}
