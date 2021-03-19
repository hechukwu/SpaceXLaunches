//
//  TestData.swift
//  SpaceXLaunchesTests
//
//  Created by Henry Chukwu on 18/03/2021.
//

import XCTest
@testable import SpaceXLaunches

class TestData {

    static var rocket: Rocket {
        return Rocket(flickr_images: nil, name: "Double 007", type: "rocket", first_flight: "2021-03-18", country: "Nigeria", company: "Jibble", wikipedia: "https://en.wikipedia.org/wiki/Double_007", description: "Double 007 is a two-stage rocket designed and manufactured by Jibble for the reliable and safe transport of satellites and the Dragon spacecraft into orbit", id: nil, active: true, stages: 2, boosters: 0, success_rate_pct: 100)
    }

    static let launchJSON: Launch = Launch(
        fairings: nil, links: nil, static_fire_date_utc: "2020-05-22T17:39:00.000Z", rocket: "5e9d0d95eda69973a809d1ec", details: "SpaceX will launch", launchpad: "5e9e4502f509094188566f88", name: "Demo Mission 2", date_local: nil, date_precision: nil, id: nil, tdb: nil, net: nil, success: true, auto_update: nil, upcoming: true, window: nil, flight_number: 98, date_utc: Date(), crew: nil, ships: nil, capsules: nil, payloads: nil, cores: nil
    )

    static var launches: [Launch] {
        var launchArr = [Launch]()
        for _ in 1...3 {
            launchArr.append(launchJSON)
        }
        return launchArr
    }
}
