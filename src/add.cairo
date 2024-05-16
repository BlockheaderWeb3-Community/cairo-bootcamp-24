pub fn add(x: u32, y: u32) -> u32 {
    x + y
}

#[cfg(test)]
mod test {
    use super::add;

    #[test]
    fn test_add() {
        assert_eq!(8, add(5, 3));
    }
}

