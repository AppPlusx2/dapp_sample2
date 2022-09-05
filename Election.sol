//SPDX-License-Identifier: UNLICENSED

pragma solidity >=0.5.0 < 0.9.0;

contract Election {
    struct Candidate{
        string name;
        uint numVotes;
    }

    struct Voter{
        string name;
        bool authorised;
        uint whom; //who this candidate is voting (he will vote the index of the candidate)
        bool voted; //bool to see if the person has already voted or not
    }

    address public owner;
    string public electionName;


    mapping(address => Voter) public voters; //the Ethereum address shall be map to a voter, you can consider as as dictionary
    Candidate[] public candidates; //we define arrays in this way, and in particular we are defining an array of Candidate, and canidates is the name of that array
    uint public totalVotes;

    function startElection(string memory _electionName) public {
        owner = msg.sender; //who has started the smartcontract will become the owner
        electionName = _electionName;
    }

    //!not everyone can add a candidate, so the owner only can do it
    modifier ownerOnly(){
        require(msg.sender == owner); //require is the same as "if" in orther languages
        _;
    }

    function addCandidate(string memory _candidateName) ownerOnly public{
        candidates.push(Candidate(_candidateName, 0)); //with this function a candidate is added to the list of candidates
    }

    function authorizeVoter (address _voterAddress) ownerOnly public{
        voters[_voterAddress].authorised = true; //this is the mapping type, capire come cazzo funziona
    }

    function getNumCandidates() public view returns(uint) {
        return candidates.length; //this is a just a function that return the number of candidates
    }

    function vote(uint candidateIndex) public{
        require(!voters[msg.sender].voted); //voter shall not be true
        require(voters[msg.sender].authorised); //voter shall be authorized
        voters[msg.sender].whom = candidateIndex;
        voters[msg.sender].voted = true;
        candidates[candidateIndex].numVotes++;
        totalVotes++;

    }



 

}