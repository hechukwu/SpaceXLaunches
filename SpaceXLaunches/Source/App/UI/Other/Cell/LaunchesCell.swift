//
//  LaunchesCell.swift
//  SpaceXLaunches
//
//  Created by Henry Chukwu on 17/03/2021.
//

import UIKit

class LaunchesCell: UITableViewCell {

    @IBOutlet weak var launchNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var indicatorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configureCell(_ launch: SpaceXLaunches) {
        launchNumberLabel.text = "\(launch.flight_number ?? 0)"
        detailsLabel.text = launch.details
        indicatorLabel.text = "\(launch.upcoming ?? false)"
        dateLabel.text = DateUtils.parseEventVerificationDate(date: launch.date_utc)
    }
}

final class DateUtils {

    static func parseEventVerificationDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "d MMM, yyyy"

        return dateFormatter.string(from: date)

    }
}
