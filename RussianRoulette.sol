//SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract RussianRouletter{
    address payable[2] players;
    uint8 index = 0;
    uint turn = 0;
    uint killed = 0;
    bool finished = false;
    event GameOver(address loser);

    constructor() {
        turn = uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, block.number, players))) % 2;

        killed = uint(keccak256(abi.encodePacked(players, block.difficulty, block.timestamp, block.number))) % 2;
    }

    function register() public payable {
        require(index < 2);
        require(msg.value >= 0.5 ether);
        players[index] = payable(msg.sender);
        index++;
        if(index == 2) {
            finished = false;
        }
    }

    modifier isSenderTurn() {
        require(msg.sender == players[turn]);
        _;
    }

     modifier gameNotFinished() {
        require(finished == false);
        _;
    }

    function shoot() public gameNotFinished isSenderTurn{
        uint shot = uint(keccak256(abi.encodePacked(players, block.difficulty, block.timestamp, block.number))) % 2;
        if(shot == killed) {
            emit GameOver(players[turn]);
            players[(turn + 1) % 2].transfer(address(this).balance);
            players[0] = players[1] = payable(address(0));
            finished = true;
        }
        turn = (turn + 1) % 2;
    }

    function getTurn() public view returns(address) {
        return players[turn];
    }

    function isFinished() public view returns(bool) {
        return finished;
    }
}