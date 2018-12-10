pragma solidity ^"0.4.24"; 

/**
 * AUTOMATIC DEPRECATION PATTERN 
 * Problem - A usage scenario requires a temporal constraint deﬁning a point in time when functions become deprecated. 
 * Solution - Deﬁne an expiration time and apply modiﬁers in function deﬁnitions to disable function execution if the 
 * expiration date has been reached. 
 **/
contract AutoDeprecateContract { 
    
    // Contract expiration time
    uint expires;
    
    // Set the contract expiration time, when the contract is created
    constructor(uint _days) public { 
        expires = now + _days * 1 minutes; 
    }
    
    // Check if the contract is expired
    function expired() internal view returns (bool) { 
        return now > expires; 
    }
    
    // Modifier to check if the contract is not yet depricated    
    modifier notDepricated() { require(!expired()); _; }

    // Modifier to check if the contract is depricated    
    modifier whenDepricated() { require(expired()); _; }
    
    // Deposits are allowed only until the contract is not depricated
    function deposit() public view notDepricated returns (bool) { 
        return true;
    }
    
    // Withdrawal is alllowed ONLY after the contract is depricated
    function withdraw() public view whenDepricated returns (bool) { 
        return true;
    }
} 