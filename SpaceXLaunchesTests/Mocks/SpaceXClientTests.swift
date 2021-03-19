//
//  SpaceXClientTests.swift
//  SpaceXLaunchesTests
//
//  Created by Henry Chukwu on 18/03/2021.
//

import Foundation
@testable import SpaceXLaunches

class SpaceXClientTests: SpaceXClientProtocol {

    func fetchLauncher(completion: @escaping (Result<[Launch], Error>) -> Void) {
        completion(.success(TestData.launches))
    }

    func fetchRocket(id: String, completion: @escaping (Result<Rocket, Error>) -> Void) {
        completion(.success(TestData.rocket))
    }
}
