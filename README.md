## Introduction to Starknet Contracts
1. Install starknet-foundry by running this command:
`curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh | sh`

2. Restart your terminal
 run `snfoundryup`

3. Use this free RPC provider: https://free-rpc.nethermind.io/sepolia-juno/

4. Create an account contract by running this command on your terminal:
`sncast -u https://free-rpc.nethermind.io/sepolia-juno/ account create -n <name> --add-profile <profile_name>`

5. Deploy the account contract:
`sncast --url https://free-rpc.nethermind.io/sepolia-juno account deploy --name <account_name>`

>`NB`
Running the above command should trigger an error: 
`error: Account balance is smaller than the transaction's max_fee`.
That why your account must be funded; to fund your account, visit - https://starknet-faucet.vercel.app/ and paste the account address that was generated on step 4 to request for testnet token.

6. Compile your contract by running: 
`scarb build`

_Output_
![alt text](images/image-3.png)

>If you get an error like `scarb: command not found`, then it means you don't have scarb installed. To install scarb, run this command in your terminal `curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh`. You can checkout the full guide [here](https://docs.swmansion.com/scarb/download.html) ![alt text](images/image-4.png)


7. Declare your contract:
`sncast --account <your_account_name> --url https://free-rpc.nethermind.io/sepolia-juno/ declare --contract-name <contract_name>`
>Example of a contract name is `AggregatorContract`

_Output_
![alt text](images/image-2.png)

8. Deploy your contract:
`sncast  --account <your_account_name> --url https://free-rpc.nethermind.io/sepolia-juno/ deploy  --class-hash <generated_class_hash>`

_Output_
![alt text](images/image-1.png)


🥳🥳🥳 You have successfully deployed your first contract


Alternatively, you can create a `snfoundry.toml` with the following config:
```
[sncast.test_deploy_24]
account = "test_deploy_24"
accounts-file = "~/.starknet_accounts/starknet_open_zeppelin_accounts.json"
url = "https://free-rpc.nethermind.io/sepolia-juno/"
```
Using this approach simplifies interactions using `sncast` as you can simply run commands this command to declare a contract:
`sncast --profile <name_of_profile_on_snfoundry.toml> declare --contract-name <name_of_contract_to_be_deployed>`

While deploying, make sure you check the constructor argument of the contract you are trying to deploy. All arguments must be passed in appropriately; for such case, use this command:
`sncast  --profile <name_of_profile_on_snfoundry.toml>  --class-hash <your_class_hash>  --constructor-calldata <your_constructor_args>`


---
## Introduction to Dispatchers
### Deployed Contracts on Sepolia Testnet
##### OwnerContract
- [x] class hash - 0x058d259a9c062f841b8658701afd553c8b51b7eb65cf1fea3e53cd33fc507a29
- [x] address -  0x10643c1ad9f6effd8af79b32163977e803db69aae21444005044aeea85efc52

##### CounterContract
- [x] class hash - 0x05f8ca4d37e05826fb90bd68d6ceff9ad3bd5a7ba51dfea46407f9f3aa723442
- [x] address - 0x5afdb452821d219d5b8bc68a44ca3c6fa4dfc313150d30d093a279c090d69e3

##### Aggregator_Contract
- [x] class hash - 0x7e10115406a93b8bdbb2019d746149105a0261540dc28992c7eaef65177d92a
- [x] address - 0x2155eb0a0daf351886d41028398e048c0c37b7aa151c5af8a3359f51ec75a20

--- 
##### Interacting with Deployed Contracts
- Invoke: to execute the logic of a state-changing (writes) function within your deployed contracts from the terminal, run
`sncast --url https://free-rpc.nethermind.io/sepolia-juno/  --account <account_name> invoke --contract-address <your_contract_address> --function "<your_function_name>" --calldata <fn_args>`
If you have configured your `snfoundry.toml` file, run:
`sncast --profile <your_profile> invoke --contract-address <your_contract_address> --function "<your_function_name>" --calldata <fn_args>`


- Call: to execute the logic of a non-state-changing (reads) function within your deployed contracts from the terminal, run:
`sncast --url https://free-rpc.nethermind.io/sepolia-juno/  --account <account_name> call --contract-address <your_contract_address> --function "<your_function_name"`


NB:

To test out dispatchers, please call the address of the `AggregatorContract` which contains dispatchers to call the logic of `Ownable` and `Counter` contracts respectively.
In the event the function to be called accepts some args, append the call `--calldata` flag to the above invoke and call commands with the appropriate args.


To compile your contract, run `scarb build`


