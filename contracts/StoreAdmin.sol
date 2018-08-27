pragma solidity ^"0.4.24";

/* Store Admin Contract */
contract StoreAdmin {

    // Store admin address
    address storeAdminAddress;

    // Store admin first name
    string firstName;

    // Store admin last name
    string lastName;

    // Store admin email address
    string emailAddress;

    event storeOwnerRegistrationEvent(address indexed storeAdminAddress, string firstName, string lastName, string emailAddress);

    // Create a modifer that checks if the msg.sender is the owner of the contract
    modifier isStoreAdmin() { require( msg.sender == storeAdminAddress,  "Only store admin can call this function." ); _;}

    // Default constructor   
    constructor() public {
        storeAdminAddress = msg.sender;
    }
   
    /* Register store admin details */
    function registerStoreAdminDetails(string _firstName, string _lastName, string _emailAddress) public isStoreAdmin() returns (bool) {
         firstName = _firstName;
         lastName = _lastName;
         emailAddress = _emailAddress;

        emit storeOwnerRegistrationEvent (storeAdminAddress, firstName, lastName, emailAddress);

        return true;
    }

/* Get store admin details */
    function getStoreAdminDetails() public view returns(address, string, string, string) {
        return (storeAdminAddress, firstName, lastName, emailAddress);
    }
}