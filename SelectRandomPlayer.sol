// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Telephone {

  // address public hi;
  address[] public players;
  // string public name = "Larry";

  // function enocdeAddress() public view returns(bytes memory) {
  //   return abi.encode(hi);
  // }

  // function encodeUintAddress() public view returns(uint) {
  //   return uint256(abi.enocde(hi));
  // }

  // function keccakFunction() public view returns(bytes32) {
  //  return keccak256(abi.encode(name));
  // }



   function pushPlayers(address _addr) external {
     players.push(_addr);
   }

  function chooseRandomPlayer() public view returns(address, uint) {
   uint index = uint256(keccak256(abi.encode(block.difficulty, block.number, msg.sender)));  
   uint indexModulus = index % players.length;
   address selectedPlayer = players[index % players.length];
   return (selectedPlayer, indexModulus);
}

} 

// function decoding() public view returns(string memory) {
//   return abi.decode(0x26e0e31a52ab7ccd9a5f9d2d75c9ac2d92a5128190acac65d0bdb20318c6356e);
// }




//0x26e0e31a52ab7ccd9a5f9d2d75c9ac2d92a5128190acac65d0bdb20318c6356e
//0xfec5016e3096956048e2563e13ca309355c33d463f991c1ca0b8e170a6868066