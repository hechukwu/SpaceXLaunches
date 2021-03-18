//
//  LaunchesCoreData+CoreDataProperties.swift
//  SpaceXLaunches
//
//  Created by Henry Chukwu on 18/03/2021.
//
//

import Foundation
import CoreData


extension LaunchesCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchesCoreData> {
        return NSFetchRequest<LaunchesCoreData>(entityName: "LaunchesCoreData")
    }

    @NSManaged public var static_fire_date_utc: String?
    @NSManaged public var rocket: String?
    @NSManaged public var details: String?
    @NSManaged public var launchpad: String?
    @NSManaged public var name: String?
    @NSManaged public var date_local: String?
    @NSManaged public var date_precision: String?
    @NSManaged public var id: String?
    @NSManaged public var tdb: Bool
    @NSManaged public var net: Bool
    @NSManaged public var success: Bool
    @NSManaged public var auto_update: Bool
    @NSManaged public var upcoming: Bool
    @NSManaged public var date_utc: Date?

}

extension LaunchesCoreData {
    func toWorkSpaceModel() -> Launch {
        let model = Launch(fairings: nil,
                           links: nil,
                           static_fire_date_utc:
                            static_fire_date_utc,
                           rocket: rocket,
                           details: details,
                           launchpad: launchpad,
                           name: name,
                           date_local: date_local,
                           date_precision: date_precision,
                           id: id,
                           tdb: tdb,
                           net: net,
                           success: nil,
                           auto_update: auto_update,
                           upcoming: upcoming,
                           window: nil,
                           flight_number: nil,
                           date_utc: date_utc ?? Date(),
                           crew: nil,
                           ships: nil,
                           capsules: nil,
                           payloads: nil,
                           cores: nil)

        return model
    }
}
