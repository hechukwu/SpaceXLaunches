import Dispatch
import UIKit

public class SpaceXClient {

    private var rocketLaunchedList = [SpaceXLaunches]()

    // MARK: Private Instance Property

    private let service = SpaceService()

    // MARK: Public methods

    public func fetchRocketLauncher(completion: @escaping (Result<[SpaceXLaunches], Error>) -> Void) {
        let launcherFetcher = service.launcherFetcher
        launcherFetcher.fetchRocketLaunches(completion: completion)
    }
}
