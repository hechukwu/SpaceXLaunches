import Foundation
import RxSwift

protocol SpaceObservableViewModelProtocol {
    func fetchSpaceLaunches()
    func setError(_ message: String)
    var launches: Observable<[Launch]> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

public class SpaceXLaunchesViewModel: SpaceObservableViewModelProtocol {

    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)

    var apiManager: SpaceXClient?
    var launches: Observable<[Launch]> = Observable([])

    // MARK: Public Instance Properties

    public let spaceClient = SpaceXClient()

    // MARK: Public Initializers

    public init() {
        fetchSpaceLaunches()
    }

    // MARK: Internal Instance Methods

    func fetchSpaceLaunches() {

        spaceClient.fetchLauncher { (result) in
            switch result {
            case .failure(let error): self.setError(error.localizedDescription)
            case .success(let launches): self.launches.value = launches
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }
}
