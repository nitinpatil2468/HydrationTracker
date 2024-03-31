//
//  CoreDataStack.swift
//  WaterTracker
//
//  Created by Abcom on 30/03/24.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    private init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
     func save(date: Date, quantity: Double){
        let reading = Reading(context: context)
        reading.date = date
         reading.quantity = Int64(quantity)
        
        do {
            try context.save()
            print("Reading saved successfully")
        } catch {
            print("Failed to save reading: \(error.localizedDescription)")
        }
    }
    
     func getAll() -> [Reading]?{
        let context = CoreDataStack.shared.context
        var entries = [Reading]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading")
        
        do {
            entries = try context.fetch(fetchRequest) as! [Reading]
            print("\(entries.count)")
        } catch {
            print("Failed")
        }
        return entries
    }
    
    
    func getLatest()->Reading?{
        return getAll()?.last
    }
    
    func update(item:Reading,quantity:Int){
        
        let context = CoreDataStack.shared.context
        var entries = [Reading]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Reading")
        
        fetchRequest.predicate = NSPredicate(format: "date = %@",
                                             argumentArray: [item.date])

        do {
            let results = try context.fetch(fetchRequest) as? [NSManagedObject]
            if results?.count != 0 { // Atleast one was returned

                // In my case, I only updated the first item in results
                results?[0].setValue(quantity, forKey: "quantity")
            }
        } catch {
            print("Fetch Failed: \(error)")
        }

        do {
            try context.save()
           }
        catch {
            print("Saving Core Data Failed: \(error)")
        }
        
    }
    
}
