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
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
