pragma solidity ^"0.4.24";

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/OnlineMarketPlace.sol";

/* Test cases for Online Market Place project */
contract TestOnlineMarketPlace {

    /* Test case to check registering store admin works as expected */
    function testStoreAdminRegistration() public {
        OnlineMarketPlace onlineMarketPlace = new OnlineMarketPlace();

        bool returnedStatus = onlineMarketPlace.registerStoreAdminDetails("Sunil", "Agrawal", "sunil@gmail.com", false);
        bool expectedStatus = true;
        
        Assert.equal (returnedStatus, expectedStatus, "Registering store admin check failed.");
    }

    /* Test case to check adding store owner works as expected */
    function testAddStoreOwner() public {
        address storeOwnerAddress = msg.sender;

        OnlineMarketPlace onlineMarketPlace = new OnlineMarketPlace();
        address returnedStoreOwnerAddress = onlineMarketPlace.addStoreOwner(storeOwnerAddress, "Mark", "Jones", "mark@gmail.com");

        Assert.equal (returnedStoreOwnerAddress, storeOwnerAddress, "Adding store owner check failed.");
    }

    /* Test case to check adding store owner works as expected */
    function testAddProduct() public {
        OnlineMarketPlace onlineMarketPlace = OnlineMarketPlace(DeployedAddresses.OnlineMarketPlace());
        bool returnedStatus = onlineMarketPlace.addProduct(1001, 5, 100);
        bool expectedStatus = true;

        Assert.equal (returnedStatus, expectedStatus, "Adding a new product to the store check failed.");
    }

    /* Test case to check adding store owner works as expected */
    function testGetProductDetails() public {
        OnlineMarketPlace onlineMarketPlace = OnlineMarketPlace(DeployedAddresses.OnlineMarketPlace());

        address storeOwnerAddress;
        uint productCode;
        uint price;
        uint quantity;

        (storeOwnerAddress, productCode, price, quantity) = onlineMarketPlace.getProductDetails(1001);

        Assert.equal (productCode, 1001, "Getting product details failed.");
        Assert.equal (price, 5, "Getting product details failed.");
        Assert.equal (quantity, 100, "Getting product details failed.");
    }

    /* Test case to check adding store owner works as expected */
    function testChangeProductPrice() public {
        OnlineMarketPlace onlineMarketPlace = OnlineMarketPlace(DeployedAddresses.OnlineMarketPlace());

        // Call the function to change the product price
        bool returnedStatus = onlineMarketPlace.changeProductPrice(1001, 6);
        bool expectedStatus = true;
        Assert.equal (returnedStatus, expectedStatus, "Change product price failed.");

        // Now go get the product details again to ensure the price is changed
        address storeOwnerAddress;
        uint productCode;
        uint price;
        uint quantity;

        (storeOwnerAddress, productCode, price, quantity) = onlineMarketPlace.getProductDetails(1001);

        Assert.equal (productCode, 1001, "Getting product details failed.");
        Assert.equal (price, 6, "Getting product details failed.");
        Assert.equal (quantity, 100, "Getting product details failed.");
    }
}