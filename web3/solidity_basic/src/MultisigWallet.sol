pragma solidity ^0.8.13;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/utils/cryptography/MessageHashUtils.sol";

contract MultisigWallet {
    using ECDSA for bytes32;
    using MessageHashUtils for bytes32;

    address public owner;
    uint256 public proposalCount;
    uint256 public requiredApprovals;
    mapping(address => bool) public voters;
    mapping(uint256 => Proposal) public proposals;

    struct Proposal {
        uint256 id;
        address to;
        uint256 value;
        bytes data;
        uint256 approvals;
        bool executed;
        mapping(address => bool) signed;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }

    constructor(address[] memory _voters, uint256 _requiredApprovals) {
        require(_requiredApprovals <= _voters.length, "Too many approvals required");

        owner = msg.sender;
        requiredApprovals = _requiredApprovals;

        for (uint i = 0; i < _voters.length; i++) {
            voters[_voters[i]] = true;
        }
    }

    function addProposal(address _to, uint256 _value, bytes memory _data) public onlyOwner {
        proposalCount++;
        Proposal storage p = proposals[proposalCount];
        p.id = proposalCount;
        p.to = _to;
        p.value = _value;
        p.data = _data;
    }

    function getMessageHash(uint256 id, address to, uint256 value, bytes memory data) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(id, to, value, data));
    }

    function vote(uint256 id, bytes memory signature) public {
        Proposal storage p = proposals[id];
        require(!p.executed, "Already executed");

        bytes32 msgHash = getMessageHash(id, p.to, p.value, p.data);
        bytes32 ethSignedHash = msgHash.toEthSignedMessageHash();
        address signer = ethSignedHash.recover(signature);

        require(voters[signer], "Not authorized voter");
        require(!p.signed[signer], "Already signed");

        p.signed[signer] = true;
        p.approvals++;

        if (p.approvals >= requiredApprovals) {
            _execute(p);
        }
    }

    function _execute(Proposal storage p) internal {
        require(!p.executed, "Already executed");

        (bool success, ) = p.to.call{value: p.value}(p.data);
        require(success, "Tx failed");
        p.executed = true;
    }

    receive() external payable {}
}