import Foundation
import RxSwift

protocol ObservableViewModelProtocol {
    func fetchRocketLaunches()
    func setError(_ message: String)
    var launches: Observable<[SpaceXLaunches]> { get  set }
    var errorMessage: Observable<String?> { get set }
    var error: Observable<Bool> { get set }
}

public class SpaceXLaunchesViewModel: ObservableViewModelProtocol {

    var errorMessage: Observable<String?> = Observable(nil)
    var error: Observable<Bool> = Observable(false)

    var apiManager: SpaceXClient?
    var launches: Observable<[SpaceXLaunches]> = Observable([]) //2

    // MARK: Public Instance Properties

//    public var launches = Variable<[SpaceXLaunches]>([])

    public let spaceClient = SpaceXClient()

    // MARK: Public Initializers

    public init() {
        fetchRocketLaunches()
    }

    // MARK: Internal Instance Methods

    func fetchRocketLaunches() {

        spaceClient.fetchRocketLauncher { (result) in
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

class Observable<T> {

    var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}
