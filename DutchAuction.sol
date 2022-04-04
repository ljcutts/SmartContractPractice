pragma solidity ^0.8.10;


interface IERC721 {
    function transferFrom(address _from, address _to, uint _nftId) external;
}

contract DutchAction {
    uint private constant DURATION = 7 days;
    IERC721 public immutable nft;
    uint public immutable nftId;
    address payable public seller;
    uint public immutable startingPrice;
    uint public immutable startAt;
    uint public immutable expiresAt;
    uint public immutable discountRate;

    constructor(uint _startingPrice, uint _discountRate, address _nft, uint _nftId) {
        seller = payable(msg.sender);
        startingPrice = _startingPrice;
        discountRate = _discountRate;
        startAt = block.timestamp;
        expiresAt = block.timestamp + DURATION;
        require(_startingPrice >= _discountRate * DURATION, "Starting price too small");
        nft = IERC721(_nft);
        nftId = _nftId;
    }
    function getPrice() public view returns(uint) {
        uint timeElasped = block.timestamp - startAt;
        uint discount = discountRate * timeElasped;
        return startingPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < expiresAt, "auction expired");
        uint price = getPrice();
        require(msg.value >= price, "NFT costs more than amount specified");
        nft.transferFrom(seller, msg.sender, nftId);
        if(msg.value > price) {
           uint refund = msg.value - price;
           payable(msg.sender).transfer(refund);
        }
        selfdestruct(seller);
    }
}