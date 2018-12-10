pragma solidity ^"0.4.24";

import "./OwnedContract.sol"; 

/**
 * MORTAL PATTERN
 * Problem - A deployed contract will exist as long as the Ethereum network exists. If a contract’s lifetime is over, it must be possible to destroy a contract and stop it from operating. 
 * Solution - Use a selfdestruct call within a method that does a preliminary authorization check of the invoking party. 
 **/

contract MortalContract is OwnedContract {
    
    /** 
    * Use a modiﬁer to ensure that only the owner of the contract can execute the selfdestruct operation, 
    * which sends the remaining Ether stored within the contract to a designated target address (provided as argument) 
    * and then the storage and code is cleared from the current state. 
    **/
    function destroy() public onlyOwner { selfdestruct(owner); }
    
    function destroyAndSend(address recipient) public onlyOwner { 
        selfdestruct(recipient); 
    }
}