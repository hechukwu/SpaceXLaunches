import Foundation
import CoreData

class CoreDataStack: NSObject {

    private(set) var persistentContainer: NSPersistentContainer = AppDelegate.standard.persistentContainer

    var managedObjectContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }

    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError

                #if DEVELOPMENT
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                #endif

                print ("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: Launches

    func getLaunches() -> [LaunchesCoreData]? {
        let object = try? managedObjectContext.fetch(LaunchesCoreData.fetchRequest()) as? [LaunchesCoreData]

        return object

    }

    func upsertLaunch(_ launch: Launch, save: Bool) -> LaunchesCoreData {

        var launchObject: LaunchesCoreData

        //first check if the content exists
        if let existingContent = managedObjectContext.fetchCaught(LaunchesCoreData.fetchRequestSorted(id: launch.id)).first {
            launchObject = existingContent
        }
        //create new one
        else {
            launchObject = NSEntityDescription.insertNewObject(forEntityName: LaunchesCoreData.ENTITY_NAME, into: managedObjectContext) as! LaunchesCoreData
            launchObject.id = launch.id
        }

        launchObject.id = launch.id
        launchObject.auto_update = launch.auto_update ?? false
        launchObject.name = launch.name
        launchObject.date_local = launch.date_local
        launchObject.details = launch.details
        launchObject.launchpad = launch.launchpad
        launchObject.date_utc = launch.date_utc
        launchObject.upcoming = launch.upcoming ?? false
        launchObject.date_precision = launch.date_precision
        launchObject.rocket = launch.rocket
        launchObject.flight_number = Int64(launch.flight_number ?? 0)

        if save {
            saveContext()
        }

        return launchObject
    }

    func deleteLaunch(save: Bool) {
        let objects = managedObjectContext.fetchCaught(LaunchesCoreData.fetchRequest())
        objects.forEach{
            managedObjectContext.delete($0)
        }

        if save {
            saveContext()
        }
    }

    @discardableResult
    func upsertLaunch(_ contents: [Launch], save: Bool) -> [LaunchesCoreData] {

        var upsertedObjects: [LaunchesCoreData] = []
        contents.forEach{
            let contentCD =
                upsertLaunch($0, save: false)
            upsertedObjects.append(contentCD)
        }

        if save {
            saveContext()
        }

        return upsertedObjects
    }
}

extension NSManagedObjectContext {

    func fetchCaught<T>(_ request: NSFetchRequest<T>) -> [T] {
        do {
            return try fetch(request)
        }
        catch {
            print(error)
            return []
        }
    }

}
