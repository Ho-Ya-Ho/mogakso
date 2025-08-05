pragma solidity ^0.8.13;

contract VotingSystem {
    address public owner;
    uint256 public proposalCount = 0;
    mapping(address => bool) public voters;
    mapping(uint256 => Proposal) private proposals;

    constructor(address[] memory initialVoters) {
        owner = msg.sender;
        for (uint i = 0; i < initialVoters.length; i++) {
            voters[initialVoters[i]] = true;
        }
    }

    struct Proposal {
        uint256 id;
        string description;
        uint256 yesVotes;
        uint256 noVotes;
        uint256 createdAt;
        bool exists;
        mapping(address => bool) voted;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    modifier onlyVoter() {
        require(voters[msg.sender], "Not authorized voter");
        _;
    }

    function addProposal(string memory _description) public onlyOwner {
        proposalCount++;
        Proposal storage p = proposals[proposalCount];
        p.id = proposalCount;
        p.description = _description;
        p.createdAt = block.timestamp;
        p.exists = true;
    }

    function vote(uint256 proposalId, bool voteYes) public onlyVoter {
        Proposal storage p = proposals[proposalId];
        require(p.exists, "Proposal does not exist");
        require(!p.voted[msg.sender], "Already voted");

        if (voteYes) {
            p.yesVotes += 1;
        } else {
            p.noVotes += 1;
        }

        p.voted[msg.sender] = true;
    }

    function getProposal(uint256 proposalId) public view returns (
        uint256 id,
        string memory description,
        uint256 yesVotes,
        uint256 noVotes,
        uint256 createdAt
    ) {
        Proposal storage p = proposals[proposalId];
        require(p.exists, "Proposal does not exist");

        return (
            p.id,
            p.description,
            p.yesVotes,
            p.noVotes,
            p.createdAt
        );
    }

    function isProposalPassed(uint256 proposalId) public view returns (bool passed, string memory reason) {
        Proposal storage p = proposals[proposalId];
        require(p.exists, "Proposal does not exist");
        require(block.timestamp >= p.createdAt + 5 minutes, "Too early to decide");

        if (p.yesVotes > p.noVotes) {
            return (true, "Proposal Passed");
        } else {
            return (false, "Proposal Rejected");
        }
    }

    function addVoter(address _voter) public onlyOwner {
        voters[_voter] = true;
    }

    function removeVoter(address _voter) public onlyOwner {
        voters[_voter] = false;
    }
}