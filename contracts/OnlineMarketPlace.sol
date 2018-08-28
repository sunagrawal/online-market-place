pragma solidity ^"0.4.24";

import "./OnlineMarketPlaceLibrary.sol";
import "./OnlineMarketPlaceInterface.sol";
import "./StoreAdmin.sol";

/* Online Market Place Contract */
contract OnlineMarketPlace is OnlineMarketPlaceInterface, StoreAdmin {

    /* Create a struct to store user details */
    struct user {
        address userAddress;
        string firstName;
        string lastName;
        string emailAddress;
    }

    /* Create a struct to store product details */
    struct product {
        address storeOwnerAddress;
        uint productCode;
        uint price;
        uint quantity;
    }
    
    /* Create a struct to store transaction details */
    struct transaction{
        uint productCode;
        uint price;
        uint quantity;
        address buyerAddress;
        address sellerAddress;
        uint orderedDate;
        string firstName;
        string lastName;
        string deliveryAddress;
    } 

    /* List to hold store owner addresses */
    address[] storeOwnerAddresses;

    /* Create a mapping that maps the store owners address to an store owner user object */
    mapping (address => user) public storeOwners;

    /* Create a mapping that maps the store owners address to list of products */
    mapping (address => product[]) public storeOwnerProducts;
    
    /* Create a mapping that maps the store owner address to list of all store transaction */
    mapping (address => transaction[]) public storeTransactions;
    
    /* Get store balance. Note this function can be enhanced easily to withdraw funds from the store */
    function getStoreBalance() public view returns(uint) { 
        
        // Get the list of products for this store owner
        transaction[] memory allStoreTransactions = storeTransactions[msg.sender];

        uint storeBalance = 0;
        for (uint i=0; i < allStoreTransactions.length; i++) {
            // Limitation - Currently I haven't handed the overpay part i.e. in case the client has paid more 
            // then this store balance will not reflect the additional paid amount.
            storeBalance = storeBalance + (allStoreTransactions[i].price * allStoreTransactions[i].quantity);
        }
  
        return storeBalance;
    }
    
    /* Buy the product */
    function buyProduct(address _storeOwnerAddress, uint _productCode, uint _quantity, string _firstName, string _lastName, 
            string _derliveryAddress) payable public stopInEmergency() returns (bool) {
       
        // Get the list of products from the store
        product[] storage listOfProducts = storeOwnerProducts[_storeOwnerAddress];
        
        // Iterate through the list of products to check if the product code already exists
        for (uint i=0; i < listOfProducts.length; i++) {
            
            if(_productCode == listOfProducts[i].productCode) {
                // Check to ensure buyer's address is not same as seller's address
                require(listOfProducts[i].storeOwnerAddress != msg.sender, "Seller is not allow to buy from it's own store :)");
                
                // Check to see if the seller has required quantity to sell
                require(listOfProducts[i].quantity >= _quantity, "Sorry the product is currently out of stock. Please try again later.");
                
                // Check to ensure that buyer has paid enough
                require(msg.value >= OnlineMarketPlaceLibrary.calculateAmount(listOfProducts[i].price, _quantity), "Amount paid is not enough for this transaction to complete successfully. Please check the amount paid and retry.");

                // Transfer the funds from the buyer to seller
                listOfProducts[i].storeOwnerAddress.transfer(msg.value);

                // Reduce the quantity
                listOfProducts[i].quantity = listOfProducts[i].quantity - _quantity;
                
                // Create a new transaction and store it in the mapping of all store transactions
                storeTransactions[_storeOwnerAddress].push(transaction(_productCode, listOfProducts[i].price, 
                        _quantity, msg.sender, listOfProducts[i].storeOwnerAddress, block.timestamp, _firstName, _lastName, _derliveryAddress));
                        
                return true;
            }
        }
        
        return false;
    }
    
    /* Change the product price */
    function changeProductPrice(uint _productCode, uint _newPrice) public stopInEmergency() returns (bool) {
        // Get the list of products for this store owner
        product[] storage listOfProducts = storeOwnerProducts[msg.sender];

        // Iterate through the list of products to check if the product code already exists
        for (uint i=0; i < listOfProducts.length; i++) {
            if(_productCode == listOfProducts[i].productCode) {
                listOfProducts[i].price = _newPrice;
                return true;
            }
        }
        
        return false;
    }

    /* Add a new product to the store owner */
    function addProduct(uint _productCode, uint _price, uint _quantity) public stopInEmergency() returns (bool) {
        
        // Check to ensure store admin can not any products
        require( msg.sender != storeAdminAddress,  "Only store owner can call this function." );

        // Get the list of products for this store owner
        product[] storage listOfProducts = storeOwnerProducts[msg.sender];

        // Iterate through the list of products to check if the product code already exists
        for (uint i=0; i < listOfProducts.length; i++) {
            require (_productCode != listOfProducts[i].productCode, "Product code already exists!");
        }
        
        // Add a new product to the list
        listOfProducts.push(product(msg.sender, _productCode, _price, _quantity));

        return true;
    }

    /* Remove existing product from the store owner */
    function removeProduct(uint _productCode) public stopInEmergency() returns (bool) {

        // Get the list of products for this store owner
        product[] storage listOfProducts = storeOwnerProducts[msg.sender];

        // Iterate through the list of products to check if the product code already exists
        for (uint i=0; i < listOfProducts.length; i++) {
            if(_productCode == listOfProducts[i].productCode) {
                // Assign the last element of the array to this location
                listOfProducts[i] = listOfProducts[listOfProducts.length-1];
                listOfProducts.length--;
                return true;
            }
        }
        
        return false;
    }

    /* Get all the product for the store owner */
    function getAllProductCodes() public view returns(uint[]) { 
        // Get the list of products for this store owner
        product[] memory listOfProducts = storeOwnerProducts[msg.sender];

        // Create a list of product codes. Note here the size of the list is equal to the the size of products list
        uint[] memory productCodes = new uint[] (listOfProducts.length);

        for (uint i=0; i < listOfProducts.length; i++) {
            productCodes[i] = listOfProducts[i].productCode;
        }
  
        return productCodes;
    }

    /* Check the availability of the product for the store owner */
    function getProductDetails(uint _productCode) public view returns(address, uint, uint, uint) { 
        require (checkProductAvailability(_productCode), "No such product found");
        
        product[] memory listOfProducts = storeOwnerProducts[msg.sender];

        for (uint i=0; i < listOfProducts.length; i++) {
            if ((listOfProducts[i].storeOwnerAddress == msg.sender) && listOfProducts[i].productCode == _productCode) {
                return (listOfProducts[i].storeOwnerAddress, listOfProducts[i].productCode,listOfProducts[i].price, listOfProducts[i].quantity) ;
            }
        }
    }

    /* Check the availability of the product for the store owner */
    function checkProductAvailability(uint _productCode) public view returns(bool) { 
        product[] memory listOfProducts = storeOwnerProducts[msg.sender];

        for (uint8 i=0; i < listOfProducts.length; i++) {
            if ((listOfProducts[i].storeOwnerAddress == msg.sender) && (listOfProducts[i].productCode == _productCode) 
                    && listOfProducts[i].quantity > 0) {
                return true;
            }
        }
  
        return false;
    }

    /* This function will allow store admin to new store owners */
    function addStoreOwner(address _storeOwnerAddress, string _firstName, string _lastName, string _emailAddress) public isStoreAdmin() stopInEmergency() returns (address){ 
        
        // Check to ensure store admin is not store owner
        require(msg.sender != _storeOwnerAddress, "Store admin can't be a store owner!");
        
        storeOwnerAddresses[storeOwnerAddresses.length++] = _storeOwnerAddress;
        storeOwners[_storeOwnerAddress] = user(_storeOwnerAddress, _firstName, _lastName, _emailAddress);
        return _storeOwnerAddress;
    }

    /* Get all store owners addresses*/
    function getAllStoreOwners() public view returns(address[]) {
        return storeOwnerAddresses;
    }

    /* Get store owner details */
    function getStoreOwnerDetails(address _storeOwnerAddress) public view returns(address, string, string, string) {
        return (storeOwners[_storeOwnerAddress].userAddress, storeOwners[_storeOwnerAddress].firstName, 
                storeOwners[_storeOwnerAddress].lastName, storeOwners[_storeOwnerAddress].emailAddress);
    }
}