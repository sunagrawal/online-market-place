pragma solidity ^"0.4.24";

/* Online Market Place Interface */
contract OnlineMarketPlaceInterface {
    
    /* Get store balance. Note this function can be enhanced easily to withdraw funds from the store */
    function getStoreBalance() public view returns(uint);
    
    /* Buy the product */
    function buyProduct(address _storeOwnerAddress, uint _productCode, uint _quantity, string _firstName, string _lastName, 
            string _derliveryAddress) payable public returns (bool);
    
    /* Change the product price */
    function changeProductPrice(uint _productCode, uint _newPrice) public returns (bool);

    /* Add a new product to the store owner */
    function addProduct(uint _productCode, uint _price, uint _quantity) public returns (bool);

    /* Remove existing product from the store owner */
    function removeProduct(uint _productCode) public returns (bool);

    /* Get all the product for the store owner */
    function getAllProductCodes() public view returns(uint[]);

    /* Check the availability of the product for the store owner */
    function getProductDetails(uint _productCode) public view returns(address, uint, uint, uint);

    /* Check the availability of the product for the store owner */
    function checkProductAvailability(uint _productCode) public view returns(bool);

    /* This function will allow store admin to new store owners */
    function addStoreOwner(address _storeOwnerAddress, string _firstName, string _lastName, string _emailAddress) public returns (address);

    /* Get store owner details */
    function getStoreOwnerDetails(address _storeOwnerAddress) public constant returns(address, string, string, string);
}