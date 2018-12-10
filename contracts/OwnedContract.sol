pragma solidity ^"0.5.0";

/**
OWNERSHIP PATTERN 
Problem -  By default any party can call a contract method, but it must be ensured that sensitive contract methods can only be executed 
           by the owner of a contract. 
Solution - Store the contract creator’s address as owner of a contract and restrict method execution dependent on the callers address. 
**/

contract OwnedContract { 
    
    // Owners address
    address public owner;
    
    // Event signature for transfer of ownership
    event LogOwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    // Modifer that checks if the msg.sender is the owner of the contract
    modifier onlyOwner() { require(msg.sender == owner); _; }
    
    // This is the constructor which registers the owner
    constructor() public { owner = msg.sender; }
    
    // Only the current owner can transfer the ownership
    function transferOwnership(address newOwner) public onlyOwner { 
        require(newOwner != address(0)); 
        emit LogOwnershipTransferred(owner, newOwner); 
        owner = newOwner; 
    }
}