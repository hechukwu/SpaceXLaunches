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

    static var launches: [Launch] {
        return []
    }
}
