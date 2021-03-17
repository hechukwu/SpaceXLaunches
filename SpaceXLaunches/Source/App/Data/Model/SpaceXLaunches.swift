import Foundation

public struct SpaceXLaunches: Codable {
    var fairings: Fairings?
    var links: Links?
    var static_fire_date_utc, rocket, details, launchpad, name, date_utc, date_local, date_precision, id: String?
//    var static_fire_date_unix: Any?
    var tdb, net, success, auto_update, upcoming: Bool?
    var window, flight_number: Int?
    var crew, ships, capsules, payloads: [String]?
//    var date_unix: Int32
    var cores: [Core]?
}

struct Fairings: Codable {
    var reused, recovery_attempt, recovered: Bool?
}

struct Links: Codable {
    var patch: Patch?
    var reddit: Reddit?
    var flickr: Flicker?
    var presskit, webcast, youtube_id, article, wikipedia: String?
}

struct Patch: Codable {
    var small, large: String?
}

struct Reddit: Codable {
    var campaign, launch, media, recovery: String?
}

struct Flicker: Codable {
    var original: [String]?
}

struct Core: Codable {
    var core, landing_type, landpad: String?
    var flight: Int?
    var gridfins, legs, reused, landing_attempt, landing_success: Bool?
}
