import Foundation

public struct Launch: Codable {
    var fairings: Fairings?
    var links: Links?
    var static_fire_date_utc, rocket, details, launchpad, name, date_local, date_precision, id: String?
    var tdb, net, success, auto_update, upcoming: Bool?
    var window, flight_number: Int?
    var date_utc: Date
    var crew, ships, capsules, payloads: [String]?
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

extension DateFormatter {
  static let iso8601Full: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    formatter.locale = Locale(identifier: "en_US_POSIX")
    return formatter
  }()
}
