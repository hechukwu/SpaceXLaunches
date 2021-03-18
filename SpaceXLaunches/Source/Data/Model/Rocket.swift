import Foundation

public struct Rocket: Codable {
    var flickr_images: [String]?
    var name, type, first_flight, country, company, wikipedia, description, id: String?
    var active: Bool?
    var stages, boosters, success_rate_pct: Int?
}
