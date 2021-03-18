import UIKit
import RxSwift
import RxCocoa

class RocketLaunchViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var wikipediaLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK: Public Instance Properties

    public var viewModel: RocketLauncheViewModel? { didSet { bindViewModel() } }

    let disposeBag = DisposeBag()
    var rocket: Rocket?

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        registerNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleLinkTapped))
        wikipediaLabel.addGestureRecognizer(tap)
        wikipediaLabel.isUserInteractionEnabled = true
        ProgressDialog.show(with: "Fetching rocket...")
        viewModel?.rocket.bind({ rocket in
            ProgressDialog.hide()
            self.rocket = rocket
            guard let flickerImages = rocket.flickr_images else { return }
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = flickerImages.count
            self.pageControl.currentPage = 0
            self.setupView()
        })

        viewModel?.error.bind({ status in
            ProgressDialog.hide()
            if status {
                self.showAlertDialog(title: "Error", message: self.viewModel?.errorMessage.value)
                self.collectionView.isHidden = true
                self.wikipediaLabel.isHidden = true
                self.descriptionLabel.isHidden = true
                self.pageControl.isHidden = true
            } else {
                self.collectionView.isHidden = false
                self.wikipediaLabel.isHidden = false
                self.descriptionLabel.isHidden = false
                self.pageControl.isHidden = false
            }
        })
    }

    private func registerNib() {
        collectionView.register(UINib(nibName: R.nib.rocketImageCell.name, bundle: nil), forCellWithReuseIdentifier: R.reuseIdentifier.rocketImageCell.identifier)
    }

    private func setupView() {
        title = rocket?.name
        descriptionLabel.text = rocket?.description
        wikipediaLabel.text = rocket?.wikipedia
    }

    @objc func handleLinkTapped(gesture: UITapGestureRecognizer) {
        if let link = wikipediaLabel.text {
            openUrl(urlString: link)
        }
    }
}

extension RocketLaunchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rocket?.flickr_images?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.rocketImageCell.identifier, for: indexPath) as? RocketImageCell else { return UICollectionViewCell() }

        pageControl.currentPage = indexPath.item
        let flickerImage = rocket?.flickr_images?[indexPath.item]
        cell.rocketImageView.sd_setImage(with: URL(string: flickerImage ?? ""), placeholderImage: UIImage(), options: [.refreshCached, .continueInBackground, .progressiveLoad], completed: nil)

        return cell
    }
}

extension RocketLaunchViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
}
