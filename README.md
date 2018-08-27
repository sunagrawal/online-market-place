# online-market-place

Oneline Market Place Project
____________________________

Description: Create an online marketplace that operates on the blockchain.

Step 1 - Administrator opens the web app. The web app reads the address and identifies that the user is an admin, showing them admin only functions, such as managing store owners. An admin adds an address to the list of approved store owners, so if the owner of that address logs into the app, they have access to the store owner functions.

Step 2 - An approved store owner logs into the app. The web app recognizes their address and identifies them as a store owner. They are shown the store owner functions. They can create a new storefront that will be displayed on the marketplace. They can also see the storefronts that they have already created. They can click on a storefront to manage it. They can add/remove products to the storefront or change any of the products’ prices. They can also withdraw any funds that the store has collected from sales.
 
Step 3 - A shopper logs into the app. The web app does not recognize their address so they are shown the generic shopper application. From the main page they can browse all of the storefronts that have been created in the marketplace. Clicking on a storefront will take them to a product page. They can see a list of products offered by the store, including their price and quantity. Shoppers can purchase a product, which will debit their account and send it to the store. The quantity of the item in the store’s inventory will be reduced by the appropriate amount.
 
 
What's implemented?

1. Contracts to demostrate the required functionality
2. 5 Test cases
3. Use a Library (a very simple library just to prove the point that it works)
4. Emergency break functionality (only supported for admin)
5. UI (very limited functionality only for Admin, so far)


How to run?

1. Create a folder with the name - online-market-project

2. Download all the files from online-market-place (github project) into this folder online-market-project (as shown below) -
   --------------------------------------------------------------------------------------------------------------------
   sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ ls -ltr
   total 80
   -rwxrwxrwx 1 sunilagr sunilagr    68 Aug 19 20:54 bs-config.json
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 19 21:22 build
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 19 22:14 migrations
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 26 16:58 contracts
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 26 18:10 test
   -rwxrwxrwx 1 sunilagr sunilagr   280 Aug 26 21:59 truffle.js
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 27 13:02 src
   -rwxrwxrwx 1 sunilagr sunilagr   342 Aug 27 13:05 package.json
   drwxrwxrwx 1 sunilagr sunilagr  4096 Aug 27 16:37 node_modules
   -rwxrwxrwx 1 sunilagr sunilagr 80441 Aug 27 16:37 package-lock.json
   --------------------------------------------------------------------------------------------------------------------
   
3. go to the online-market-project directory and run the following commands -
   truffle compile (as shown below)
   --------------------------------------------------------------------------------------------------------------------
   sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ truffle compile
   Compiling ./contracts/OnlineMarketPlace.sol...
   Compiling ./contracts/OnlineMarketPlaceInterface.sol...
   Compiling ./contracts/OnlineMarketPlaceLibrary.sol...
   Compiling ./contracts/StoreAdmin.sol...
   Writing artifacts to ./build/contracts
   --------------------------------------------------------------------------------------------------------------------
   
4. Now open a new propmt and start ganache-cli using the following command (as shown below) -
   --------------------------------------------------------------------------------------------------------------------
   sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ ganache-cli
   Ganache CLI v6.1.6 (ganache-core: 2.1.5)

   Available Accounts
   ==================
   (0) 0x1483c23660942eb00e9c22452dfa934ab49276ba (~100 ETH)
   (1) 0x49cb37e03a91acd6ab0a5c8a1c3db96843f60d6c (~100 ETH)
   (2) 0x3ec3241ebe13f7abcac6a927e5eb07575e43fafc (~100 ETH)
   (3) 0xe72263ffcc62ce301dfc5aa56bb276fb870cb916 (~100 ETH)
   (4) 0xed90d9c2f80831a90ba60d3a0fae7afc263a6f50 (~100 ETH)
   (5) 0x1c01b5cf62943d5ed569aa95c3af7696c52a0a0c (~100 ETH)
   (6) 0xd4b2381e98f54ce7bfe3247e192183b40bd021d7 (~100 ETH)
   (7) 0x8df00fbd1e60f9a6a78e256c333f1d17ba14d493 (~100 ETH)
   (8) 0x161a6263fbb7b7ccc6d4ebc03208529bc95111b2 (~100 ETH)
   (9) 0x751831786359d1ed629c2c90af613d277885271b (~100 ETH)

   Private Keys
   ==================
   (0) 0x8d1f5367e791a3c51689933557a98317cdae01f4f5b994bd40852f5897e8e5a6
   (1) 0x3f844ffa0918703733de721eb2d66bfb736251883fd13aaa31c1caff7ca0f84b
   (2) 0x464aaad8b269e14e5d27525345ef128023ee3a419fa1ed8c7966293102762f52
   (3) 0x0a60f33b144f95efed68a5c3c0208ee31e320440c998b152ad82b8ad3fc9d3f1
   (4) 0x8ca14d1cd1f26acb849502863bd177ade4e32621e15d196bfc5c1dc49426206e
   (5) 0x5cb0e5151ca3dd743ede12261e362dd21a101b3f674a70b961951d2a28599267
   (6) 0xc969960e2f4f416acbda78417b1e5447a66563ee9fd1df1aa4906600dc9e5ef0
   (7) 0xe9fab9e93764b3218b448306b3458e16d5d2686474cbd539960d2946073a807a
   (8) 0x726e46299229222d941c6383e850ac18e176fb12cde8f3e46d40d822ef157379
   (9) 0x7757b0953ea575de44675ffae5c599f5d116a73dba6b6b0716f84e8d45753b7b

   HD Wallet
   ==================
   Mnemonic:      hole deliver manual crater behave dust title gorilla collect impact option code
   Base HD Path:  m/44'/60'/0'/0/{account_index}

   Gas Price
   ==================
   20000000000

   Gas Limit
   ==================
   6721975

   Listening on 127.0.0.1:8545
   --------------------------------------------------------------------------------------------------------------------

5. Now we are ready to migrate our contracts using the following command -
   truffle migrate (as shown below)
   --------------------------------------------------------------------------------------------------------------------
   sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ truffle migrate
   Using network 'development'.

   Running migration: 1_initial_migration.js
     Deploying Migrations...
     ... 0x0c817e9f84a1676ca0745c4e205259a5cfac2fd4c9193af058d3250bb3a302f1
     Migrations: 0xb98a6c1c900e136ef3a8809c745c8bb1a0f409f8
   Saving successful migration to network...
     ... 0xdb0e9896dd8d40b212f6305c3dcb61121568d60b34f63b794d8c77fd5fa6dc30
   Saving artifacts...
   Running migration: 2_deploy_contracts.js
     Deploying OnlineMarketPlaceLibrary...
     ... 0x679ab48b04c6ac029515cca4e3fbd9844ac3530b7f4090bfa82c0638e4d2c132
     OnlineMarketPlaceLibrary: 0x1beac1ad92ab15ed10c099b98c5fa796bb30a55b
     Linking OnlineMarketPlaceLibrary to OnlineMarketPlace
     Deploying OnlineMarketPlace...
     ... 0xa08fadb253ed4067e12de3f3713270641c6bdd2f7c39333e5f2c2f3a85ae91f0
     OnlineMarketPlace: 0x8148fcf671bc6c9f325e56ee9b5be3e3ca7dc963
   Saving successful migration to network...
     ... 0xbdff9d9e11805ab20904b187ddb7d11f7544a1cf1d3c622362c4759a0a4d2ef3
   Saving artifacts...
   --------------------------------------------------------------------------------------------------------------------
   Note - You can copy the contract address above from the highlighted location of your truffle migration output, 
   to load the contract from the specified address in remix editor for testing.
 
6. Now we are ready to run the tests using the following command -
   truffle test (as shown below)
   --------------------------------------------------------------------------------------------------------------------
   sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ truffle test
   Using network 'development'.

   Compiling ./contracts/OnlineMarketPlace.sol...
   Compiling ./contracts/OnlineMarketPlaceInterface.sol...
   Compiling ./contracts/OnlineMarketPlaceLibrary.sol...
   Compiling ./contracts/StoreAdmin.sol...
   Compiling ./test/TestOnlineMarketPlace.sol...
   Compiling truffle/Assert.sol...
   Compiling truffle/DeployedAddresses.sol...

   TestOnlineMarketPlace
     ✓ testStoreAdminRegistration (178ms)
     ✓ testAddStoreOwner (220ms)
     ✓ testAddProduct (160ms)
     ✓ testGetProductDetails (164ms)
     ✓ testChangeProductPrice (150ms)

   5 passing (2s)
   --------------------------------------------------------------------------------------------------------------------
   Note here, I have written 5 test cases to test the functionality of some of key methods as specified in the interface e.g. 
   Registering Store Admin, Adding Store Owner, Adding Product, Getting Product Details and Changing Product Price. Ideally
   speaking, i would like to add more test cases, as time permits.
  
 7. Finally, go to https://remix.ethereum.org/ and first load the contracts from the online-market-project/contract folder 
    in the remix editor. Check to ensure no compilation error, then go to run tab and use the above specified contract address 
    to load the contract. Now you are good to test the contract function in remix.
    
 8. Run the following command to start the lite-server, and test the contract from the UI interface. First go to the project 
    directory i.e. online-market-project and run the following command -
    npm run dev  (as shown below)
    --------------------------------------------------------------------------------------------------------------------
    sunilagr@LAPTOP-LF3RARPG:/mnt/d/online-market-project$ npm run dev

    > online-market-place@1.0.0 dev /mnt/d/online-market-project
    > lite-server

    ** browser-sync config **
    { injectChanges: false,
      files: [ './**/*.{html,htm,css,js}' ],
      watchOptions: { ignored: 'node_modules' },
      server:
       { baseDir: [ './src', './build/contracts' ],
         middleware: [ [Function], [Function] ] } }
    [Browsersync] Access URLs:
     --------------------------------------
           Local: http://localhost:3000
        External: http://192.168.1.245:3000
     --------------------------------------
              UI: http://localhost:3001
     UI External: http://192.168.1.245:3001
     --------------------------------------
    [Browsersync] Serving files from: ./src
    [Browsersync] Serving files from: ./build/contracts
    [Browsersync] Watching files...
    18.08.27 16:52:50 304 GET /index.html
    18.08.27 16:52:50 304 GET /css/bootstrap.min.css
    18.08.27 16:52:50 304 GET /js/bootstrap.min.js
    18.08.27 16:52:50 304 GET /js/app.js
    18.08.27 16:52:50 304 GET /js/web3.min.js
    18.08.27 16:52:50 304 GET /js/truffle-contract.js
    18.08.27 16:52:51 200 GET /OnlineMarketPlace.json
    --------------------------------------------------------------------------------------------------------------------
    Note here, you need node_module packge in the project directory. So if you find the above command doesn't work, 
    then first install npm by running the following command in the project directory -
    npm install
    
    
 How to test?
 --------------
 1. Open browser and type http://localhost:3000/
 Note - I'm assuming you have already configured and linked meta mask to your local block chain using the seed from the output of 
 ganahce-cli.
 2. The page should automatically recongnise you as admin (if you are using the same account on meta mask that's used for contract  deployment).
 
 NOTE - I haven't managed to finish the UI completely due to some unplanned travel during the course. So the UI functionality is 
 very limited and bare bone to demostrate the concept that you can call the contract function from the web based application.
   
   
