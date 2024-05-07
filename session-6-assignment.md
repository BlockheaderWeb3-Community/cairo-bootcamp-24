`Session-6 Assignment`

1. Refer to the `KillSwitch` contract: https://github.com/starknet-edu/kill-switch/blob/master/src/lib.cairo
2. Modify this `KillSwitch` contract by adding the following to the trait:
```
fn activate(self: @TContractState); // this turns the is_active variable to true
fn deactivate(self: @TContractState); // this turns the is_active variable to false
```
3. Add the implementation of the above trait
4. Import the `KillSwitch` contract interface into `AggregatorContract` 
5. Modify the `increase_aggr_count_by_two` function in the `AggregatorContract` to only successfully update the `aggr_count` only when the `is_active` state variable of `KillSwitch` contract is true
6. Deploy `KillSwitch` contract
7. Redeploy `Aggregator` contract
8. Test out the logic of `5` above and provide a valid txn hash as proof that this logic works
9. Create a `session-6-solution.md` file with summary of your workings including the txn hash of `8` above
10. Create a PR against `starknet-contract` branch