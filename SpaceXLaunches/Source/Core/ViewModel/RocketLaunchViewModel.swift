import Foundation
import RxSwift

protocol RocketObservableViewModelProtocol {
    func fetchRocketLaunched(id: String)
    func setError(_ message: String)
    var rocket: Observable<Rocket> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

public class RocketLauncheViewModel: RocketObservableViewModelProtocol {

    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)

    var apiManager: SpaceXClient?
    var rocket: Observable<Rocket> = Observable(Rocket())

    // MARK: Public Instance Properties

    public let spaceClient = SpaceXClient()

    // MARK: Public Initializers

    public init(id: String) {
        fetchRocketLaunched(id: id)
    }

    func fetchRocketLaunched(id: String) {
        spaceClient.fetchRocket(id: id) { result in

            switch result {
            case .failure(let error): self.setError(error.localizedDescription)
            case .success(let rocket): self.rocket.value = rocket
            }
        }
    }

    func setError(_ message: String) {
        self.errorMessage = Observable(message)
        self.error = Observable(true)
    }
}
