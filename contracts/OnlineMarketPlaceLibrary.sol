pragma solidity ^"0.4.24";

/* Online Market Place Library */
library OnlineMarketPlaceLibrary {

    /* Function to calcuate the amount reqired for the buyer */
    function calculateAmount(uint price, uint quantity) public pure returns (uint) {
        return price * quantity;
    }

    /* Function to convert address to string type */    
    function toString(address x) public pure returns (string) {
        bytes memory b = new bytes(20);
        
        for (uint i = 0; i < 20; i++) {
            b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        }

        return string(b);
    }
}