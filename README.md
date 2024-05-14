# Introduction to Testing Cairo Programs
On this branch of the repo, we explored an introduction to writing tests for Cairo programs. This branch builds upon the existing code on [`cairo-program`](https://github.com/BlockheaderWeb3-Community/cairo-bootcamp-24/tree/cairo-program) branch.

## Setting up Development Environment
Same as [Setting up Development Environment(cairo-program branch)](https://github.com/BlockheaderWeb3-Community/cairo-bootcamp-24/blob/cairo-program/README.md?tab=readme-ov-file#setting-up-development-environment)

## Running tests
To run all the tests in all the program files, use this command:
```scarb cairo-test```

### Filtering tests
To filter tests by the test name, use this command:
```scarb cairo-test <test_name>```

e.g `scarb cairo-test test_sub_num`

### Test cases
The example test cases are all located in [`basic_arithmetic_ops.cairo`](https://github.com/BlockheaderWeb3-Community/cairo-bootcamp-24/blob/introduction-to-testing/src/basic_arithmetic_ops.cairo)

The test cases covers the following techniques:
- `assert!()`
- `assert_eq!()`
- `assert_ne!()`
- `assert_ge!()`
- `assert_lt!()`
- `#[should_panic]`
- `#[should_panic(expected)]`
- `#[available_gas()]`

## Resources
- To learn more about writing tests for cairo programs: Check [How to write tests - Cairo Book](https://book.cairo-lang.org/ch10-01-how-to-write-tests.html)

