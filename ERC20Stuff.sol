pragma solidity ^0.8.0;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';
import '@openzeppelin/contracts/token/ERC20/IERC20.sol';

/*
 ERC20
 -transfer
 - approve, allowance, transferFrom
*/

// interface IERC20 {
//     function totalSupply() external view returns(uint256);
//     function balanceOf(address account) external view returns(uint256);
//     function transfer(address recipient, uint256 amount) external returns(bool);
//     function allowance(address owner, address spender) external view returns(uint256);
//     function approve(address spender, uint256 amount) external returns(bool);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns(bool);

//     event Transfer(address indexed from, address indexed to, uint256 value);
//     event Approval(address indexed owner, address indexed spender, uint256 value);
// }

contract MyToken is ERC20 {
  constructor(string memory name, string memory symbol) ERC20(name, symbol) public {
      _mint(msg.sender, 100*10**18);
  }
}

contract TokenSwap {
    IERC20 public token1;
    address public owner1;
    IERC20 public token2;
    address public owner2;

    constructor(address _token1, address _token2, address _owner1, address _owner2) public {
        token1 = IERC20(_token1);
        owner1 = _owner1;
        token2 = IERC20(_token2);
        owner2 = _owner2;
    }

    function swap(uint _amount1, uint _amount2) public {
      require(msg.sender == owner1 || msg.sender == owner2, "Not authorized");
      require(token1.allowance(owner1, address(this)) >= _amount1, "Token 1 allowance too low");
      require(token2.allowance(owner2, address(this)) >= _amount2, "Token 2 allowance too low");
      //transfer tokens
      //token1, owner1, amount1 -> owner2
      _safeTransferFrom(token1, owner1, owner2, _amount1);
       //token2, owner2, amount2 -> owner1
      _safeTransferFrom(token2, owner2, owner1, _amount2);
    }

    function _safeTransferFrom(IERC20 token, address sender, address recipient, uint amount) private {
        bool sent = token.transferFrom(sender, recipient, amount);
        require(sent, "Transfer did not go through");

    }
}

