var OnlineMarketPlaceLibrary = artifacts.require("./OnlineMarketPlaceLibrary.sol");
var OnlineMarketPlace = artifacts.require("./OnlineMarketPlace.sol");
    
module.exports = function(deployer) {
    deployer.deploy(OnlineMarketPlaceLibrary);
    deployer.link(OnlineMarketPlaceLibrary, OnlineMarketPlace);    
    deployer.deploy(OnlineMarketPlace);
};