pragma solidity ^"0.4.24";

/* Store Admin Contract */
contract StoreAdmin {

    // Emergency flag
    bool public stopped = false;

    // Store admin address
    address storeAdminAddress;

    // Store admin first name
    string firstName;

    // Store admin last name
    string lastName;

    // Store admin email address
    string emailAddress;

    /* Log an event when the store admin registers */
    event storeOwnerRegistrationEvent(address indexed storeAdminAddress, string firstName, string lastName, string emailAddress, bool stopped);

    // Modifier to stop the flow in case of an emergency
    modifier stopInEmergency { require (!stopped); _;}

    // Modifier to withdraw funds once the emergency stop is applied 
    modifier onlyInEmergency { require (stopped); _;}

    // Create a modifer that checks if the msg.sender is the owner of the contract
    modifier isStoreAdmin() { require( msg.sender == storeAdminAddress,  "Only store admin can call this function." ); _;}

    // Default constructor   
    constructor() public {
        storeAdminAddress = msg.sender;
    }
   
    /* Register store admin details */
    function registerStoreAdminDetails(string _firstName, string _lastName, string _emailAddress, bool _stopped) public isStoreAdmin() returns (bool) {
         firstName = _firstName;
         lastName = _lastName;
         emailAddress = _emailAddress;
         stopped = _stopped;

        /* Log an event when the store admin registers */
        emit storeOwnerRegistrationEvent (storeAdminAddress, firstName, lastName, emailAddress, stopped);

        return true;
    }

    /* Get store admin details */
    function getStoreAdminDetails() public view returns(address, string, string, string, bool) {
        return (storeAdminAddress, firstName, lastName, emailAddress, stopped);
    }
}