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
      return App.markRegistered();
    });

    return App.bindEvents();
  },

  bindEvents: function() {
    $(document).on('click', '.btn-register', App.handleRegistered);
  },

  markRegistered: function() {
    App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
      var onlineMarketPlaceInstance = instance;
      return onlineMarketPlaceInstance.getStoreAdminDetails();
      alert("Get store admin details function called from address [" + web3.eth.defaultAccount + "]");
    }).then(function(result) {
        if (result[0] == web3.eth.defaultAccount) {
          $('#WelcomeMessage').text("Welcome Store Admin!!!");
          document.getElementById("AdminAddressText").value = result[0];
          document.getElementById("FirstNameText").value = result[1];
          document.getElementById("LastNameText").value = result[2];
          document.getElementById("EmailAddressText").value = result[3];
          document.getElementById("EmergencyStopText").value = result[4];
        }
    }).catch(function(err) {
      console.log(err.message);
    });
  },

  handleRegistered: function() {
    web3.eth.getAccounts(function(error, accounts) {
      if (error) {
        console.log(error);
      }

      App.contracts.OnlineMarketPlace.deployed().then(function(instance) {
        var onlineMarketPlaceInstance = instance;

        // Convert the emergency stop text field to boolean
        var stopped = document.getElementById("EmergencyStopText").value;
        var boolValue = JSON.parse(stopped); 
        
        // Execute adopt as a transaction by sending account
        return onlineMarketPlaceInstance.registerStoreAdminDetails(document.getElementById("FirstNameText").value, 
            document.getElementById("LastNameText").value, document.getElementById("EmailAddressText").value, boolValue, {from: web3.eth.defaultAccount});
      }).then(function(result) {
        // $('#registerButton').text('Success').attr('disabled', true);
        return App.markRegistered();
      }).catch(function(err) {
        console.log(err.message);
      });
    });
  }

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});