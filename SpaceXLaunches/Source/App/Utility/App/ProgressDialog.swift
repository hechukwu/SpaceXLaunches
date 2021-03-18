import Foundation
import SVProgressHUD

final class ProgressDialog {
    static func show(with message: String?) {
        DispatchQueue.main.async {
            SVProgressHUD.show(withStatus: message)
            SVProgressHUD.setDefaultMaskType(.black)
        }
    }

    static func hide() {
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}
