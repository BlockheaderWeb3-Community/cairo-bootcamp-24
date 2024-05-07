# Introduction to Cairo

This repo introduces the core fundamentals for writing Cairo program

##  Setting Up Development Environment

### 1. Scarb
Cairo can be installed by simply downloading Scarb. Scarb bundles the Cairo compiler and the Cairo language server together in an easy-to-install package so that you can start writing Cairo code right away.

Run the following in your terminal, then follow the onscreen instructions. This will install the latest stable release.

``` =shell
curl --proto '=https' --tlsv1.2 -sSf https://docs.swmansion.com/scarb/install.sh | sh
```


To check if scarb is successfully installed, run either: 
- `scarb --version` - returns the version of scarb
- `which scarb` - returns the path to the scarb bin on your maching 


### Install Scarb via asdf (for macOS and Linux only)
`asdf` is a CLI tool that can manage multiple language runtime versions on a per-project basis. 

Install `asdf`:
- https://asdf-vm.com/guide/getting-started.html

- Run the following command to add the scarb plugin:
- `asdf plugin add scarb`

With scarb installed, you are set to writing Cairo programs. 

## Introduction to Starknet Contracts
1. Install starknet-foundry by running this command:
`curl -L https://raw.githubusercontent.com/foundry-rs/starknet-foundry/master/scripts/install.sh | sh`

2. Restart your terminal
 run `snfoundryup`

3. Use this free RPC provider: https://free-rpc.nethermind.io/sepolia-juno/

4. Create an account contract by running this command on your terminal:
sncast -u https://free-rpc.nethermind.io/sepolia-juno/ account create -n <name> --add-profile <profile_name>

5. Deploy the account contract:
sncast --url https://free-rpc.nethermind.io/sepolia-juno account deploy --name <account_name> 

`NB`
Running the above command should trigger an error: 
error: Account balance is smaller than the transaction's max_fee.
That why your account must be funded; to fund your account, visit - https://starknet-faucet.vercel.app/ 

Compile your contract by running: scarb build

Declare your contract:
sncast --account test_deploy -u <url> declare --contract-name <contract_name>

Deploy your contract:
sncast  --account <your_account> --url <your_rpc_url> deploy  --class-hash <generated_class_hash>

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

##### AggregatorContract
- [x] class hash - 0x03cda0dfba87206ed7b8861729a3af653af6682b2c76ec6d4ca73dbd41a5fc11
- [x] address - 0x1b963d5bcc6bcacd3fdd0d2fec50a6e4ac8b150a74ef2221a4b3622ffe94ec3


--- 
##### Interacting with Deployed Contracts
Invoke: to execute the logic of a state-changing (writes) function within your deployed contracts from the terminal, run
sncast --url <your_rpc_url>  --account <account_name> invoke --contract-address <your_contract_address> --function "<your_function_name>" --calldata <fn_args>



Call: to execute the logic of a non-state-changing (reads) function within your deployed contracts from the terminal, run:
sncast --url <your_rpc_url>  --account <account_name> call --contract-address <your_contract_address> --function "<your_function_name"


NB:

To test out dispatchers, please call the address the AggregatorContract which contains dispatchers to call the logic of Ownable and Counter contracts respectively
In the event the function to be called accepts some args, append the call --calldata flag to the above invoke and call commands with the appropriate args



To compile your program, run `scarb build`


