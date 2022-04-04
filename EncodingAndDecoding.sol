pragma solidity >=0.7.0 <0.9.0;

contract EncodingAndDecoding {
    uint public amount = 1;
    address public sender = address(this);
    
    function receiveData(uint _amount) external view returns(bytes memory) {
        bytes memory data = abi.encode(_amount, sender);

        return data;
    }

     function receiveData1(uint _amount) external view returns(bytes memory) {
        bytes memory data2 = abi.encodePacked(_amount, sender);

        return data2;
    }

      function receiveData2(uint _amount) external view returns(bytes32) {
        bytes32 data3 = keccak256(abi.encodePacked(_amount, sender));

        return data3;
    }

    function decode(bytes calldata _data) external view returns(uint, address) {

     
     (address sender1, uint amount1) = abi.decode(_data, (address, uint));

     return (amount1, sender1);
    }

}