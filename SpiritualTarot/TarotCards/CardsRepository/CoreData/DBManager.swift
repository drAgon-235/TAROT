//
//  DBManager.swift
//  SpiritualTarot
//
//  Created by Slawo Dragon on 14.02.24.
//

import Foundation
import CoreData

struct DBManager {
    
    // Singleton:
    static let shared = DBManager()
    
    init() {
        container = NSPersistentContainer(name: "CardModel")
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error with Core Data: \(error), \(error.userInfo)")
            }
        }
    }
    
    // Variables:    
    private let container: NSPersistentContainer
    var context: NSManagedObjectContext { container.viewContext }

    // Functions:
    // Self made:
    // checking if CoreDB container is empty (we want to fill the CoreDB only once, initially, see VM):
    func containerIsEmpty() -> Bool {
        var isEmpty = false
        do {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Card")
            let count = try context.count(for: request)
            
            if count == 0 {
                isEmpty = true
            } else {   }
        } catch {
            isEmpty = true
        }
        return isEmpty
    }
    
    // Save boiler plate:
    func save() {
        guard context.hasChanges else { return }
        
        do {
            try context.save()
        } catch let error as NSError {
            NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
        }
    }
    
    

    

    
}
