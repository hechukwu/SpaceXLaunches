import UIKit
import RxSwift
import RxCocoa

class SpaceXLaunchesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    // MARK: Public Instance Properties

    public var viewModel: SpaceXLaunchesViewModel? { didSet { bindViewModel() } }

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        viewModel = SpaceXLaunchesViewModel()
        registerNib()

        viewModel?.launches.bind({ (launches) in
            self.tableView.reloadData()
        })
    }

    private func registerNib() {
    }
}

extension SpaceXLaunchesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vm = viewModel else { return 0 }
        return vm.launches.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
