App = {
  web3Provider: null,
  contracts: {},

  init: function() {
    // Is there an injected web3 instance?
    if (typeof web3 !== 'undefined') {
      App.web3Provider = web3.currentProvider;
    } else {
      // If no injected web3 instance is detected, fall back to Ganache
      App.web3Provider = new Web3.providers.HttpProvider('http://127.0.0.1:8545');
    }

    web3 = new Web3(App.web3Provider);
    return App.initContract();
  },

  initContract: function() {
    $.getJSON('OnlineMarketPlace.json', function(data) {
      // Get the necessary contract artifact file and instantiate it with truffle-contract
      var OnlineMarketPlaceArtifact = data;
      App.contracts.OnlineMarketPlace = TruffleContract(OnlineMarketPlaceArtifact);

      // Set the provider for our contract
      App.contracts.OnlineMarketPlace.setProvider(App.web3Provider);

      // Use our contract to register store admin
      return App.handleAllStoreOwners();
    });
  },

  handleAllStoreOwners: function() {
    var count = 0;

    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;       
      return onlineMarketPlaceInstance.getAllStoreOwners();
    }).then(function(result) {
        for (var i in result) {
          if (web3.eth.defaultAccount == result[i]) {
            $('#StoreOwnerWelcomeMessage').text("Welcome Store Owner!!!");
            App.handleGetStoreOwnerDetails(result[i]);
            count++;
          }
        }

        if (count == 0) {
          App.handleGetStoreAdminDetails();
        }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleGetStoreAdminDetails: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.getStoreAdminDetails();
    }).then(function(result) {
        if (result[0] == web3.eth.defaultAccount) {
          window.location.href = "index.html";
        } else {
          window.location.href = "buyer.html";
        }
    }).catch(function(err) {
      console.log(err.message);
    });
  },  

  handleGetStoreOwnerDetails: function(storeOwnerAccount) {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.getStoreOwnerDetails(storeOwnerAccount);
    }).then(function(result) {
      document.getElementById("StoreOwnerAddressText").value = result[0];
      document.getElementById("StoreOwnerFirstNameText").value = result[1];
      document.getElementById("StoreOwnerLastNameText").value = result[2];
      document.getElementById("StoreOwnerEmailAddressText").value = result[3];
   }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleGetStoreBalance: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.getStoreBalance();
    }).then(function(result) {
      document.getElementById("StoreBalanceText").value = result;
   }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleAddProduct: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.addProduct(document.getElementById("ProductCodeText").value, document.getElementById("PriceText").value,
            document.getElementById("QuantityText").value, {from: web3.eth.defaultAccount});
    }).then(function(result) {
      $('#AddProductWelcomeMessage').text("Product added successfully. Product Id [" + document.getElementById("ProductCodeText").value + "]");
   }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleRemoveProduct: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.removeProduct(document.getElementById("RemoveProductCodeText").value, {from: web3.eth.defaultAccount});
    }).then(function(result) {
      $('#RemoveProductWelcomeMessage').text("Product removed successfully. Product Id [" + document.getElementById("RemoveProductCodeText").value + "]");
   }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleChangeProductPrice: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.changeProductPrice(document.getElementById("ChangeProductCodeText").value, 
            document.getElementById("ChangePriceText").value, {from: web3.eth.defaultAccount});
    }).then(function(result) {
        $('#ChangeProductPriceWelcomeMessage').text("Product price changed successfully. Product Id [" + document.getElementById("ChangeProductCodeText").value + "]");
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleGetAllProductCodes: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;       
      document.getElementById("ListAllProductsTextArea").value = "";
      return onlineMarketPlaceInstance.getAllProductCodes();
    }).then(function(result) {
        for (var i in result) {
          App.handleGetProductDetails(result[i]);
        }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleGetProductDetails: function(productCode) {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.getProductDetails(productCode);
    }).then(function(result) {
        document.getElementById("ListAllProductsTextArea").value =  document.getElementById("ListAllProductsTextArea").value 
            + result[1] + ", " + result[2] + ", " + result[3] + "\n";
  }).catch(function(err) {
      console.log(err.message);
    });
  }
}
$(function() {
  $(window).load(function() {
    App.init();
  });
});