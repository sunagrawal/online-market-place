pragma solidity ^"0.5.0";

import "./OwnedContract.sol"; 

/** 
 * ACCESS RESTRICTION PATTERN 
 * Problem - By default a contract method is executed without any preconditions being checked, but it is desired that the execution 
 * is only allowed if certain requirements are met. 
 * Solution - Deﬁne generally applicable modiﬁers that check the desired requirements and apply these modiﬁers in the function deﬁnition. 
 **/
 
contract AccessRestrictionContract is OwnedContract {
    
    // Contract creation time
    uint public creationTime = now;
    
    // Modifier that check if now is 1 min after the contract creation time    
    modifier onlyAfter(uint _time) { require(now > _time); _; }
    
    // Modifer that check if the given condition is true
    modifier condition(bool _condition) { require(_condition); _; }
    
    // Calculate payment
    function calculatePayment() public view onlyAfter(creationTime + 1 minutes) onlyOwner() condition(msg.sender.balance >= 50 ether) returns (bool) { 
        return true;
    }
}