# Create and Mint Token

This Solidity program is simple to use for minting, transferring, and burning tokens .write a smart contract to create your own token on a local HardHat network. 
Once you have your contract, you should be able to use Remix to interact with it. 
From remix, the contract owner should be able to mint tokens to a provided address. Any user should be able to burn and transfer tokens.

## Description

This program is a simple contract written in Solidity, a programming language used for developing smart contracts on the Ethereum blockchain. 
The contract has multiple functions for minting, transferring, and burning tokens. It contains the constructor so that name and symbol can be taken from user before deploying.
It also contains the token owner address and total supply to take the global address and the total number of tokens issued.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar.
Save the file with a .sol extension (e.g., Token.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract MyFirstToken {
    string public Token_name;
    string public Token_symbol;
    uint256 public TotalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    address public Token_owner;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Burn(address indexed from, uint256 value);
    event Mint(address indexed to, uint256 value);

    constructor(string memory _Entername, string memory _Entersymbol) {
        Token_name = _Entername;
        Token_symbol = _Entersymbol;
        TotalSupply = 0;
        Token_owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == Token_owner, "Only the contract owner can call this function");
        _;
    }

    function mint(address to, uint256 value) external onlyOwner {
        require(to != address(0), "Invalid recipient address");
        require(value > 0, "Invalid amount");

        TotalSupply += value;
        balanceOf[to] += value;

        emit Mint(to, value);
        emit Transfer(address(0), to, value);
    }

    function burn(uint256 value) external {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        TotalSupply -= value;
        balanceOf[msg.sender] -= value;

        emit Burn(msg.sender, value);
        emit Transfer(msg.sender, address(0), value);
    }

    function transfer(address to, uint256 value) external returns (bool) {
        require(to != address(0), "Invalid recipient address");
        require(value > 0, "Invalid amount");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }
}


```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.18" (or another compatible version), and then click on the "Compile Token.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar, and before that name the token and symbol also. 
Select the "Token" contract from the dropdown menu, and then click on the "Deploy" button.
Once the contract is deployed, you can interact with it by calling the mint, burn, and transfer functions. 
Click on the "Token" contract in the left-hand sidebar, and then click on the 3  functions. Finally, click on the "transact" button to execute the function and retrieve the desire result.

## Authors

Yash Bedi 
[@YashBedi_25](https://twitter.com/Yash_Bedi25)


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
