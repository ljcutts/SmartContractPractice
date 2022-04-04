pragma solidity >=0.4.21 <0.9.0;
pragma experimental ABIEncoderV2;

contract Election {
  string public name;
  string public description;


    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;

    mapping(address => bool) public voters;

    uint public candidatesCount;

    constructor(string[] memory _nda, string[] memory _candidates) public {
        require(_candidates.length > 0, "There should be at least 1 candidate");
        name = _nda[0];
        description = _nda[1];
        for(uint i = 0; i < _candidates.length; i++) {
            addCandidate(_candidates[i]);
        }
    }

    function addCandidate(string memory _name) private {
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        candidatesCount++;
    }

    function vote(uint _candidate) public {
        require(!voters[msg.sender], "Voter has already Voted!");
        require(_candidate <= candidatesCount && _candidate >= 1, "Invalid candidate to Vote!");
        voters[msg.sender] = true;
        candidates[_candidate].voteCount++;
    }
}

contract MainContract{
    uint public electionId = 0;
    mapping(uint => address) public Elections;

    constructor(string[] memory _nda, string[] memory _candidates) {
        Election election = new Election(_nda, _candidates);
        Elections[electionId] = address(election);
        electionId++;
    }
}