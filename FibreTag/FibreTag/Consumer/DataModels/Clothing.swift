import Foundation

struct Clothing: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var company: String
    var price: Double
    var imageUrl: String
    var model: String
    var isLiked: Bool = false
}

var clothes: [Clothing] = [
    Clothing(name: "Pegasus Trail", company: "Nike", price: 210, imageUrl: "item_00001", model: "sneaker.usdz", isLiked: false),
    Clothing(name: "Cardholder", company: "Louis Vuitton", price: 2400, imageUrl: "nft2", model: "nft2.usdz", isLiked: true),
    Clothing(name: "T-Shirt", company: "Givenchy", price: 350, imageUrl: "nft3", model: "nft3.usdz", isLiked: false),
    Clothing(name: "Purse", company: "Chanel", price: 1400, imageUrl: "nft4", model: "nft4.usdz", isLiked: true),
    Clothing(name: "Coat", company: "Brioni", price: 4300, imageUrl: "nft5", model: "nft5.usdz", isLiked: true),
    Clothing(name: "Sneakers", company: "Brunello Cucinelli", price: 995, imageUrl: "nft6", model: "nft6.usdz", isLiked: true),
    Clothing(name: "Jacket", company: "Gucci", price: 2300, imageUrl: "nft7", model: "nft7.usdz", isLiked: false),
    Clothing(name: "Leather Bag", company: "Louis Vuitton", price: 230, imageUrl: "nft8", model: "nft8.usdz", isLiked: true)
]

var arClothes: [Clothing] = [
    Clothing(name: "Pegasus Trail", company: "Nike", price: 210, imageUrl: "item_00001", model: "sneaker.usdz", isLiked: false)
]

var nfcClothes: [Clothing] = [
    Clothing(name: "T-Shirt", company: "Vechain", price: 140, imageUrl: "vechain", model: "sneaker.usdz", isLiked: false)
]
