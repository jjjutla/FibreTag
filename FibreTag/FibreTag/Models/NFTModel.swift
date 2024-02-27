import Foundation
import SwiftUI

struct NFTModel: Hashable, Identifiable {
    var id = UUID()
    var name: String
    var hash: String
    var price: Double
    var thumbnail: String
    var model: String
    var assetAddress: String
    var url: URL?
}

let models: [NFTModel] = [
    NFTModel(name: "Pegasus Trail", hash: "2344", price: 0.6788, thumbnail: "nft", model: "sneaker.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Grape", hash: "2669", price: 0.455, thumbnail: "clothing-1", model: "nft2.usdz", assetAddress: "0xe1dc516b1486aba548eecd2947a11273518434a4"),
    NFTModel(name: "Cool Cat", hash: "9466", price: 0.777, thumbnail: "nft3", model: "nft3.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Formation", hash: "200", price: 0.015, thumbnail: "nft4", model: "nft4.usdz", assetAddress: "0xd32938e992a1821b6441318061136c83ea715ba1"),
    NFTModel(name: "Cool Cat", hash: "207", price: 0.9, thumbnail: "nft5", model: "nft5.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "OnChain Monkey", hash: "495", price: 1.38, thumbnail: "nft6", model: "nft6.usdz", assetAddress: "0x960b7a6bcd451c9968473f7bbfd9be826efd549a"),
]

let ownedModels: [NFTModel] = [
    NFTModel(name: "Cat", hash: "200", price: 0.158, thumbnail: "cat", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Dino", hash: "4215", price: 0.558, thumbnail: "dino", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Sproto Pepe", hash: "1523", price: 0.0218, thumbnail: "sproto1", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Sproto Pepe", hash: "1346", price: 0.123, thumbnail: "sproto2", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Sproto Pepe", hash: "5931", price: 0.158, thumbnail: "sproto3", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c")
]

let featuredModels: [NFTModel] = [
    NFTModel(name: "KuKu", hash: "3718", price: 0.0048, thumbnail: "kuku1", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Nyan Ballon", hash: "1857", price: 0.017, thumbnail: "nyan1", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "KuKu", hash: "4307", price: 0.0048, thumbnail: "kuku2", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "1337 Brian", hash: "3376", price: 0.0035, thumbnail: "brian", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Nyan Balloon", hash: "2952", price: 0.019, thumbnail: "nyan2", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c")
]

let nftModels: [NFTModel] = [
    NFTModel(name: "octoGAN", hash: "935", price: 0.6758, thumbnail: "octogan1", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "BALLOON QUEST", hash: "8", price: 0.09, thumbnail: "balloonquest", model: "nft.usdz", assetAddress: "0xd342c260bb971026fe48afed6341ffc4697ee16f"),
    NFTModel(name: "REKT CHIMP", hash: "7", price: 0.5, thumbnail: "rektchimp", model: "nft.usdz", assetAddress: "0xd342c260bb971026fe48afed6341ffc4697ee16f"),
    NFTModel(name: "octoGAN", hash: "1109", price: 0.69, thumbnail: "octogan2", model: "nft.usdz", assetAddress: "0x1a92f7381b9f03921564a437210bb9396471050c"),
    NFTModel(name: "Mystical Quest", hash: "10", price: 0.1, thumbnail: "mysticalquest", model: "nft.usdz", assetAddress: "0xd342c260bb971026fe48afed6341ffc4697ee16f")
]
