import UIKit
import RxSwift
import RxCocoa

class SpaceXLaunchesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    // MARK: Public Instance Properties

    public var viewModel: SpaceXLaunchesViewModel? { didSet { bindViewModel() } }

    let disposeBag = DisposeBag()
    var filteredLaunches = [SpaceXLaunches]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        viewModel = SpaceXLaunchesViewModel()
        registerNib()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        viewModel?.launches.bind({ (launches) in
            guard let keyDate = Calendar(identifier: .gregorian).date(byAdding: .year, value: -3, to: Date()) else { return }
            self.filteredLaunches = launches.filter{ $0.date_utc > keyDate }
            self.tableView.reloadData()
        })
    }

    private func registerNib() {
        tableView.register(UINib(nibName: R.nib.launchesCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.launchesCell.identifier)
    }
}

extension SpaceXLaunchesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredLaunches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.launchesCell.identifier) as? LaunchesCell else { return UITableViewCell() }

        let launch = filteredLaunches[indexPath.row]
        cell.configureCell(launch)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let launch = filteredLaunches[indexPath.row]
        if let vc = R.storyboard.main.spaceXDetailLaunchVC() {
            vc.launch = launch
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
