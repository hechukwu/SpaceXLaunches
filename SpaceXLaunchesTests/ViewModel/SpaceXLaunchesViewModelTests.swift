//
//  SpaceXLaunchesViewModelTests.swift
//  SpaceXLaunchesTests
//
//  Created by Henry Chukwu on 18/03/2021.
//

import XCTest
@testable import SpaceXLaunches

class SpaceXLaunchesViewModelTests: XCTestCase {

    private func createViewModel(_ apiClient: SpaceXClientProtocol) -> SpaceXLaunchesViewModel {
        return SpaceXLaunchesViewModel(apiClient: apiClient)
    }

    func test_whenInitialized_storesInitParams() throws {
        let viewModel = createViewModel(SpaceXClientTests())
        XCTAssertNotNil(viewModel.spaceClient)
        XCTAssertNotNil(viewModel.launches.value)
    }

}
