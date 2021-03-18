import Dispatch
import UIKit

public class SpaceXClient {

    private var rocketLaunchedList = [Launch]()

    // MARK: Private Instance Property

    private let service = SpaceService()

    // MARK: Public methods

    public func fetchLauncher(completion: @escaping (Result<[Launch], Error>) -> Void) {
        let launcherFetcher = service.launcherFetcher
        launcherFetcher.fetchLauncher(completion: completion)
    }

    public func fetchRocket(id: String, completion: @escaping (Result<Rocket, Error>) -> Void) {
        let rocketFetcher = service.rocketFetcher
        rocketFetcher.fetchRocketLaunches(id: id, completion: completion)
    }
}
