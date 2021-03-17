import UIKit

class SpaceXDetailLaunchViewController: BaseViewController {

    @IBOutlet weak var rocketImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wikipediaLabel: UILabel!

    var launch: SpaceXLaunches?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        title = launch?.name
        descriptionLabel.text = launch?.details
        wikipediaLabel.text = launch?.links?.wikipedia
        rocketImageView.sd_setImage(with: URL(string: launch?.links?.patch?.large ?? ""), placeholderImage: UIImage(), options: [.refreshCached, .continueInBackground, .progressiveLoad], completed: nil)
    }
}
