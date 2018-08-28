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
    });
  },

  handleBuyProduct: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.buyProduct(document.getElementById("StoreOwnerAddressText").value, parseInt(document.getElementById("ProductCodeText").value), 
            parseInt(document.getElementById("QuantityText").value), document.getElementById("BuyerFirstNameText").value,
            document.getElementById("BuyerLastNameText").value, document.getElementById("BuyerShippingAddressText").value, {from: web3.eth.defaultAccount});
    }).then(function(result) {
      $('#BuyProductWelcomeMessage').text("Congratulatoins!!! Your transaction has been successfully completed!");
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