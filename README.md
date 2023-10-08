# FiTag: Sustainable Luxury Fashion

FiTag is a Luxury Fashion tracking iOS app that promotes transparency in a brands supply chain through the vechain blockchain. From sourcing to sale, we utilize NFC tags to ensure full transparency and assist brands with compliance in the latest sustainability regulations get by the Fashion Industry Charter. Beyond serving as a marketplace, FiTag promotes a circular economy with its rental model, and our NFT's not only guarantee product authenticity but also provides digital ownership. Additionally, our loyalty tokens unlock exclusive AR try-ons and early product releases elevating the shopping experience while minimising on global shipping.

## Images
<img src=https://github.com/nkoorty/FiTag/assets/80065244/fc89838c-f3e1-4605-8860-8b19b313c4bd width=16% height=16% >
<img src=https://github.com/nkoorty/FiTag/assets/80065244/b55fb765-0738-4327-8591-98a89ec9afae width=16% height=16% >
<img src=https://github.com/nkoorty/FiTag/assets/80065244/03f9d28f-e029-4c6d-b0be-472dbbad06ce width=16% height=16% >
<img src=https://github.com/nkoorty/FiTag/assets/80065244/310785a7-49dc-4251-a4bc-6392db1fb747 width=16% height=16% >
<img src=https://github.com/nkoorty/FiTag/assets/80065244/9e86d745-7a94-47de-b6b9-5da8558241d7 width=16% height=16% >
<img src=https://github.com/nkoorty/FiTag/assets/80065244/5660ba72-bc82-4d7e-8c9f-26a8ffe6f54f width=16% height=16% >

## Solved Problems
- [85% of fashion's carbon emissions](https://web-assets.bcg.com/1e/23/d9e9792a4988b61e708794baa174/bcg-sustainability-metaverse-in-fashion-opportunity-or-threat-oct-2022.pdf) come from distribution and suppliers; our blockchain record identifies major emitters. 
- By 2023, the [Fashion Industry Charter](https://unfccc.int/climate-action/sectoral-engagement-for-climate-action/fashion-charter) mandates a 50% emission cut for all brands; we assess supply chain data to verify brand compliance. 
- [The USA discards over 2,150 tons of clothing per second](https://wiltonchamber.com/event-detail/sustainability-in-fashion-curating-an-ethically-conscious-closet/#:~:text=Did%20you%20know%20that%20Americans,pieces%20of%20clothing%20per%20second.); our rental service promotes a circular fashion economy. 
- [21% of digital users (10-25 years) buy fashion just for social media posts](https://www.businessoffashion.com/reports/retail/gen-z-fashion-in-the-age-of-realism-bof-insights-social-media-report/); our AR feature lets influencers virtually try on outfits, reducing global shipping.
- Easy on-boarding of users using a walletless Google authentication and fiat payments using Chargebee.


## Incentives:
### For Consumers:
- **Proof of Authenticity:** Each NFT serves as a digital certificate of authenticity. WIth counterfeits rampant in the luxury market having an NFT assures the consumer of the item’s genuineness. 
- **Digital Ownership:** The NFT represents digital ownership allowing consumers to showcase their luxury items in virtual spaces such as metaverses or social media platforms
- **Resale Value:** With the NFT, the resale market becomes more transparent. A buyer can verify the item's history, ensuring it's genuine and well-maintained, potentially increasing its resale value.
- **Exclusive Access:** Loyalty passes can grant customers exclusive access to brand events, AR try ons or early releases enhancing their luxury shopping experience.

### For Brands, Manufacturers and Suppliers:
- **Counterfeit Deterrences:** By issuing NFT's brands can significantly deter counterfeiting as replicating physical items wont come with the genuine NFT.
- **Expanding Brand Reach:** By authenticating used or rented luxury items, brands can attract and assure a broader range of customers, including those with lower incomes, thereby widening their market presence.
- **Enhanced Customer Engagements and Retention:** NFT’s can be integrated with AR exper
iences or the metaverse offering unique brand interactions in a growing marker.The loyalty program, backed by token incentives, encourages repeat purchases and engagement. 
- **Data Insights:** By tracking consumer behavior through token redemptions and NFT interactions, brands can gain valuable insights to tailor marketing strategies and product launches. Brands can monitor secondary markets such as the resale market, ginning insights into product life cycles, demand and consumer behaviour, prodiving more data.
- **Regulation Compliance:** Allows brands to get compliant with regulations and streamline audits: Fashion Industry Charter for Climate Action (Will be enforced by the end of 2030 to cut emissions in the fashion industry by 50%)
- **Enhanced Brand Image:** Adopting a transparent and sustainable model enhances the brand's image, appealing to the growing demographic of conscious consumers.
- **Reduced Returns:** With features like AR try-ons, consumers can make more informed decisions, potentially reducing return rates. 
- **Market Differentiation:** In a competitive market, being a part of a transparent blockchain system can differentiate a supplier or manufacturer from competitors, potentially attracting more business.


## Business Model and Tokenomics:
- The rental model can also be a source of continuous revenue to cover gas fees.
- A portion of the platforms profits can be set in a pool to hedge against future gas fee volatility.
- Brands or users can stake a certain amount of VET tokens for VTHO, which can be used to cover the operational costs on the platform.
- Users with the loyalty pass can earn VTHO to offset gas fees by making purchases and leaving reviews.

## Technical Features:
PoC Metamask Vechain: [Link](https://metamask-fitag.vercel.app/?testnets=true)


![MM](https://github.com/nkoorty/FiTag/assets/22000925/6a15b83c-3127-4e39-8b1f-64b3942ab703)


Fiat Payments using Chargebee: [Link](https://payments-fitag.vercel.app/)

We integrated blockchain onboarding with traditional economic systems by leveraging social logins and fee delegation. Utilizing the OpenZeppelin Wizard, a mintable and burnable NFT contract is generated, representing user payments. The vechain.energy API serves as a bridge for web applications to interact with the blockchain. Upon a successful transaction via payment gateways via chargebee the backend mints an NFT to the user's wallet, which is subsequently burned at the subscription's end. Chargebee manages the financial aspects, providing webhook notifications to the backend about subscription statuses. All interactions, including minting and burning of NFTs, are handled through API calls, ensuring seamless integration. 


![fiat](https://github.com/nkoorty/FiTag/assets/22000925/2f8e1480-a6fc-4094-a3b7-8b21c300bf70)


### MIT License

Copyright (c) 2023 Artemiy Malyshau, Adesh Dooraree, Jeevan Jutla

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so.

See the [LICENSE](LICENSE) file for details.
