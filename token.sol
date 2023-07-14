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
