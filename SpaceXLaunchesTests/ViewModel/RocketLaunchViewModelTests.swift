//
//  RocketLaunchViewModelTests.swift
//  SpaceXLaunchesTests
//
//  Created by Henry Chukwu on 18/03/2021.
//

import XCTest
@testable import SpaceXLaunches

class RocketLaunchViewModelTests: XCTestCase {

    private func createViewModel(_ apiClient: SpaceXClientProtocol) -> RocketLauncheViewModel {
        return RocketLauncheViewModel(id: "", apiClient: apiClient)
    }

    func test_whenInitialized_storesInitParams() throws {
        let viewModel = createViewModel(SpaceXClientTests())
        XCTAssertNotNil(viewModel.spaceClient)
        XCTAssertNotNil(viewModel.rocket.value)
    }

}
