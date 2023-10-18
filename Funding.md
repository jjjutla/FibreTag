# FibreTag - vechain x Easy A Startup Grant Application
## Project Overview
* Problem statement: BCG track
* Are you applying for the grant with the same project you submitted at the vechain Hackathon: **No**

### Team Details
* Project name: FibreTag
* Team name: FibreTag (previously FiTag at the hackathon)
* GitHub handle: https://github.com/jjjutla/FibreTag
* College/Employer: Imperial College London, King's College London, Binance
* Payment Address: 0xBdd509667c30c04bBA844819373fa028A0ED3294

## Overview
FibreTag is an iOS app that uses the VechainThor Blockchain to enhance brand trust in the luxury fashion industry. By tracking and disclosing product origins, manufacturing procedures, raw materials, and previous owners, we combat counterfeits and champion sustainability. Utilizing NFC technology, FibreTag offers users an in-depth view of a product's journey from raw material to purchase. Additionally, each purchase comes with a unique NFT digital twin, ensuring authenticity and providing transparency for conscious consumers.

### Why vechain?
Vechain's reputable collaborations with luxury brands and its anti-counterfeiting solutions make it a natural fit for FibreTag. Its scalable technology aligns with our requirements, and our shared focus on sustainability in fashion is further strengthened by vechain's immutable records, ensuring the unalterable transparency of a product's journey and sourcing. Smart contracts on vechain automate and validate transactions, guaranteeing adherence to ethical and sustainable practices. Vechain's easy to use toolset streamlines our development process and their transparent framework amplifies FibreTag's commitment to authenticity. 

### Project vechain/BCG one-pager

### Pitch deck

## Project Overview

### Mockups/Design components
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/815e40f9-dd56-4c20-a309-aa8deb025e4d" height="280px">
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/670be707-cd5d-4998-9a28-4f2689faaeb2" height="280px">
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/9ad17fc9-480a-4152-9de4-9a9e895f09e8" height="280px">
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/cc91c022-1893-4b8e-b9fc-9f7d2bf292d4" height="280px">
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/bddbc665-0427-4db5-8e05-cc95531de201" height="280px">
<img src="https://github.com/jjjutla/FibreTag/assets/80065244/7e8daa36-08b6-4ac2-9eb3-7977d117b5cf" height="280px">

---

### API Specifications

#### POST /items/register
Purpose: Register a new luxury item in the system and on the blockchain
Body:
* nfcUID: Unique NFC identifier
* itemName: Name of the item
* description: Description of item
Response:
* success: True/False
* itemID: Unique ID of the item generated on the backend
* message: Success or Error message

#### POST /items/updateStage
Purpose: Update the stage of an item in the supply chain
Body:
* itemID: Unique ID of the item
* nfcUID: Unique NFC identifier
* stage: The stage (e.g. “Manufacturing”, “Packaging”, “Shipping”) 
* action: “start" or "stop". Indicates whether the stage is being started or completed.
* workerID: ID of the worker updating the stage
* timestamp: Date-time of the action. If not provided, server current time is used.
Response:
* success: True/False
* message: Success or Error message

#### GET /items/{itemID}/history
Purpose: The main objective of this endpoint is to provide a comprehensive history of a luxury item. This history captures every stage of the item's journey within the supply chain. By accessing this, third-party developers, businesses, or end-users can validate the authenticity and provenance of the item, ensuring that it adheres to the standards and processes claimed by the seller or manufacturer. 
Headers:
* API-Key: Unique API key assigned to a registered user.
Parameters:
* itemID: Unique ID of the item
Response:
* success: True/False
* item: Details of the item
* istory: Array of historical stages and associated details

#### POST /items/generateNFT:
Purpose: This endpoint serves to mint the NFT digital twin immediately after a sale. Using google walletless login, the user's wallet is identified, and the NFT is minted and sent directly to that wallet. The vechain.energy API key is used as a blockchain bridge to the luxury store’s payment processor. 
Body:
* itemID: Unique ID of the item
* paymentID: Unique ID of the payment provided by the payment provider
* userWalletAddress: Wallet address of the user obtained through the walletlessAPI
Response:
* success: True/False
* nftID: Unique ID of the generated NFT
* message:Success or error message indicating if the NFT minting was successful or not.

#### GET /items/{itemID}/nftDetails:
Purpose: Get details of the associated NFT digital twin for an item.
Parameters:
* itemID: Unique ID of the item
Response:
* success: True/False
* nftDetails: Details of the associated NFT.

#### POST /workers/authenticate:
Purpose: Authenticate a worker, ensuring only authorized personnel can update items. 
Body:
* workerID: Unique ID of the worker
* password: Worker password (servier side hashed and salted)
Response:
* success: True/False
* Token: Auth token for subsequent authenticated requests (JWT)
* message:Success or error message

#### POST /users/walletlessLogin:
Purpose: This endpoint enables users to perform a walletless login using Google OAuth on the web interface for brands to view data. The primary function is to authenticate users via Google and simultaneously retrieve their associated public wallet address. Please note that the iOS app is going to use Google Firebase in order to perform the same actions.
Body:
* googleToken: The token provided by Google upon user authentication
Response:
* success: True/False
* userID: Unique ID of the user in your system
* userWalletAddress: Waller address of the user obtained through Google Auth integration
* message: Success or error message, indicating the result of the process.

---

### Technology Stack

* REST API backend running Web3.js/Thorify to interact with smart contracts
* Solidity Tracking smart contract
* Digital Twin NFT contract
* FIAT Payment contract
* Vechain.energy API key as blockchain bridge
* iOS frontend written in Swift using SwiftUI/UIKit. App is built using MVVM architecture, widely regarded as the one of the best mobile architectures for clearly separating UI and internal logic using internal Xcode target frameworks
* Basic Web frontend to visualize tracking history


When a user downloads the app they are presented with several login options - login as a manufacturer scanning and updating tag information or as a consumer wanting to view the history and validate authentication. To allow for an easy onboarding we have a conventional login using Google OAuth which is integrated through Google Firebase, which acts as the server backend for all centralized FibreTag information that does not require the immutability or decentralization of the VechainThor blockchain. Upon successful account creation, certain premium features within the app are locked until activated with a valid API key.

The app provides an easy overview of the FibreTag marketplace, where FibreTag acts as a middle man for users to purchase products from companies that partner with FibreTag. Additionally, users are able to scan the physical NFC tags in the clothing to validate and ensure the validity and origins of their clothing. On top of that, the NFT phygital feature is used to its fullest extent when operated via the iOS app due to the amount of native support Apple provides with its ARKit and RealityKit libraries. Please keep in mind that users can store their private keys for their wallets locally on device using SwiftData und UserDefaults - 2 features Apple provides for device-only information.

Brands and manufacturers submit requests to the backend during manufacturing. After verifying the requests, the API employs Web3.js to interact with the Solidity smart contract. Once processed on-chain, users can request the product history through a getHistory API call.

For a user to purchase an item on the luxury brand’s website the payment provider returns to the website with a specific payment ID and simultaneously informs the backend about a new NFT to be created. The backend, in turn, triggers the vechain.energy-API to mint an NFT corresponding to the purchase ID. As the user waits, the NFT, once created, is sent to their wallet, and they receive a confirmation of the successful transaction.

---

### Documentation of deployed components
#### User Onboarding
**A Walletless Login with Google OAuth**
* Mobile endpoint: Google Firebase, Web endpoint: /users/walletlessLogin
* User signs in via Google OAuth to allow for a familiar and easy-to-use process
* On successful authentication, Google provides a token which is passed to the backend
* The backend validates this token with Google’s servers, retrieves user details and the associated wallet address
* Users are logged in and presented with their dashboard depending on if they are a worker scanning tags in the manufacturing * process or a consumer validating the authenticity of their product and the supply chain

#### Tracking Luxury Items through the Supply Chain
**Registering a New Item**
* Endpoint: POST /items/register
* Workers or manufacturers can register a new luxury items
* This registers and assigns the NFC tag on the item to a unique ID

**Updating the Item’s Stage in the Supply Chain**
* Endpoint: POST /items/{itemID}/updateStage
* As the item progresses through various stages (e.g. manufacturing, quality check, packaging) the associated NFC tag is scanned using the iOS app.
* Each scan updates the item's stage and records relevant data (like timestamp, location, and worker details).
* This data is logged on the Vechain Thor blockchain

**Checking the Item’s History**
* Endpoint: GET  /items/{itemID}/history
* Anyone can retrieve the complete history of an item using its unique ID.
* For non FibreTag members or workers they can request a paid API key to access this endpoint and validate any items data.
* The history fetched from the VeChain blockchain provides a transparent record of the item's journey.

#### Purchase & NFT Generation
**User Purchases an Item**
* If the user purchases an item from the luxury store, upon successful payment the transaction provides a unique payment ID.

**Minting the NFT Digital Twin**
* Endpoint: POST  /items/generateNFT
* Once the payment is confirmed the backend receives a notification to mint a new NFT.
* The backend interacts with the Vechain Thor blockchain via the vechain.energy-API, instructing it to mint an NFT associated with the payment ID.
* This NFT acts as a digital twin, representing the authenticity and ownership of the physical luxury item.
* Once minted the NFT is sent directly to the user;s wallet associated with their Google account

---

### PoC/MVP

[https://github.com/nkoorty/Fitag](https://github.com/nkoorty/Fitag)

MVP was submitted for the EasyA x vechain hackathon, however, significant changes will be made to the MVP in terms of expanding on the core functionalities of what was previously known as FiTag. While the general design will be similar, the tracking and verification aspect is going to be the main focus of FibreTag.

## Ecosystem Fit

**IYK (https://iyk.app/)**

IYK is an invite-only platform to provide consumers with “IYK modules” that act as tags that one can attach to physical clothing items in order to create a phygital representation of said clothing item. 

IYK focuses on the consumer of the clothing, hence, while FibreTag heavily focuses on the transparency of the supply chain and how both brands and users alike can increase brand trust and loyalty, respectively.

**DRESSX (https://dressx.com)**

DRESSX is a digital fashion platform where users can purchase and wear digital-only clothing items on their photos or in augmented reality, aiming to provide a sustainable alternative to fast fashion by reducing the physical production of garments.

Unlike FibreTag, DRESSX primarily emphasises the concept of digital fashion and its environmental benefits. FibreTag, on the other hand, offers a comprehensive view of a product's journey through the use of blockchain and NFC technologies, ensuring transparency and combating counterfeits in the luxury fashion market, while also providing the physical item. Furthermore, with FibreTag's unique NFT digital twin system, it not only guarantees the product's authenticity but also promotes unparalleled transparency for both brands and users.

## Team

### Team Members
* Name of Team Leader: Jeevan Jutla
* Name of Team Member: Artemiy Malyshau

### Team's Experience

**Jeevan Jutla**: Jeevan is a security engineer at Binance who has worked in the blockchain industry for 2 years. Jeevan has recently graduated from King's College London with a First Class Honors in Electronic Engineering and won several blockchain hackathons (vechain, Tezos, Polkadot, etc).

**Artemiy Malyshau**: Artemiy is a postgraduate Imperial College London studying CS & Engineering. Artemiy has recently graduated from King's College London with a First Class Honors in Electronic Engineering and has worked at crypto start-ups based in Austria and won a variety of hackathons, ranging from Web2 (IC Hack 23, biggest hackathon in the UK) to Web3 (vechainTezos, ImmutableX, Polkadot).

### Team's Code Repositories
* https://github.com/jjjutla/Melobyte
* https://github.com/jjjutla/Corda-CBDC-Backend
* https://github.com/nkoorty/rl_parking
* https://github.com/nkoorty/ICHack23

### Team LinkedIn profiles
Jeevan: https://www.linkedin.com/in/jeevan-jutla/
Artemiy: https://www.linkedin.com/in/artemiy-malyshau/

## Development Roadmap

## Future Plans

## Additional Information
This project was initially built for the vechain x EasyA hackathon held at Harvard University, where it finished 1st for the BCG track. For the purpose of this application, the project scope has been updated and adjusted accordingly in order to reflect a clear unique selling point (USP), and product market fit (PMF). Additionally, the infrastructure plans for bothe backend and frontend have been significantly improved.
