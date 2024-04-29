pub fn is_sum_even(n1: u16, n2: u16) -> bool {
    let sum: u16 = n1 + n2;
    if sum % 2 == 0 {
      return true;
    }
    return false;
}

pub fn check_is_even(num: u16) -> bool {
    if num % 2 == 0 {
      return true;
    }
    return false;
}