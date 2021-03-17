import UIKit
import SafariServices

class BaseViewController: UIViewController {

    var hideNavigationBarOnAppear = false

    public private(set) var isViewVisible = false

    // MARK: Public Instance Methods

    public func bindViewModel() {
    }

    // MARK: Overridden UIViewController Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        bindViewModel()
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if !isViewVisible {
            isViewVisible = true
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //
        // Force view to load before mucking with any subviews:
        //
        if #available(iOS 9.0, *) {
            loadViewIfNeeded()
        } else {
            guard
                view != nil
                else { return }
        }
        navigationController?.navigationBar.isHidden = hideNavigationBarOnAppear
    }

    override public func viewWillDisappear(_ animated: Bool) {
        if isViewVisible {
            isViewVisible = false
        }

        super.viewWillDisappear(animated)
    }

    fileprivate func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlertDialog(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertDialogAndDismiss(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.cancel,handler: {_ in
            self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func openUrl(url: String) {
        if let url = URL(string: url) {
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = true

                let vc = SFSafariViewController(url: url, configuration: config)
                present(vc, animated: true)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    func showImagePicker(viewcontroller: UIImagePickerControllerDelegate & UINavigationControllerDelegate) {

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = viewcontroller

        let actionSheet = UIAlertController(title: "Choose a photo source", message: nil, preferredStyle: .actionSheet)

        let camera = UIAlertAction(title: "Camera", style: .default) { action in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }

        let photo = UIAlertAction(title: "Photo Library", style: .default) { action in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        actionSheet.addAction(camera)
        actionSheet.addAction(photo)
        actionSheet.addAction(cancel)

        present(actionSheet, animated: true)
    }

}
