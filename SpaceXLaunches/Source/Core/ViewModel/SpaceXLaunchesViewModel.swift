import Foundation
import RxSwift

protocol SpaceObservableViewModelProtocol {
    func fetchSpaceLaunches()
    var launches: Observable<[Launch]> { get  set }
}

public class SpaceXLaunchesViewModel: SpaceObservableViewModelProtocol {

    var launches: Observable<[Launch]> = Observable([])

    // MARK: Public Instance Properties

    public let spaceClient: SpaceXClientProtocol?
    let coreDataStack = CoreDataStack()

    // MARK: Public Initializers

    public init(apiClient: SpaceXClientProtocol) {
        self.spaceClient = apiClient
        fetchLaunchesFromCoreData()
        fetchSpaceLaunches()
    }

    // MARK: Internal Instance Methods

    func fetchLaunchesFromCoreData() {
        if let launches = coreDataStack.getLaunches() {
            let contents: [Launch] = launches.map {
                return $0.toWorkSpaceModel()
            }
            self.launches.value = contents
        }
    }

    func fetchSpaceLaunches() {

        spaceClient?.fetchLauncher { (result) in
            switch result {
            case .failure: break
            case .success(let launches): self.launches.value = launches
            }
        }
    }
}
