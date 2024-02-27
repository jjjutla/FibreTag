import Foundation

struct MarketplaceItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var company: String
    var imageUrl: String
    var price: Double
}
