pragma solidity ^0.8.0;

contract EtherWallet {
    mapping(address => uint) balances;


    function deposit(uint _amount) public payable {
      balances[msg.sender] += _amount;
    }

    function withdraw(uint _amount) public {
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }


    function viewContractBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    fallback() external payable {
     
    }
}