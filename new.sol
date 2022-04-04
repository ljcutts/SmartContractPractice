pragma solidity ^0.8.10;

contract Account {
    address public bank;
    address public owner;

    constructor(address _owner) payable {
        bank = msg.sender;
        owner = _owner;
    }
}

contract ContractFactory {
    Account[] accounts;
    function makeNewContract(address _owner) external {
      Account account = new Account{value: 111}(_owner);
      accounts.push(account);
    }
}