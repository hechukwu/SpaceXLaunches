//
//  LaunchesCoreData+CoreDataClass.swift
//  SpaceXLaunches
//
//  Created by Henry Chukwu on 18/03/2021.
//
//

import Foundation
import CoreData

@objc(LaunchesCoreData)
public class LaunchesCoreData: NSManagedObject {

    static let ENTITY_NAME = String(describing: LaunchesCoreData.self)

    @nonobjc public class func fetchRequestSorted(id: String? = nil) -> NSFetchRequest<LaunchesCoreData> {
        let request = NSFetchRequest<LaunchesCoreData>(entityName: ENTITY_NAME)
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]

        var predicates: [NSPredicate] = []
        if let id = id {
            predicates.append(NSPredicate(format: "id == %@", id))
        }
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        return request
    }
}
