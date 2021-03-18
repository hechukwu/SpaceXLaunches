//
//  DateUtils.swift
//  SpaceXLaunches
//
//  Created by Henry Chukwu on 18/03/2021.
//

import Foundation

class DateUtils {

    static func parseEventVerificationDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "d MMM, yyyy"

        return dateFormatter.string(from: date)

    }
}
