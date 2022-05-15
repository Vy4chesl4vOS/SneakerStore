//
//  CoreDataManager.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var context: NSManagedObjectContext {
        self.persistentContainer.viewContext
    }
    
    init () {
        self.persistentContainer = NSPersistentContainer(name: "SneakerModel")
        self.persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                print("error load persistent store \(error.localizedDescription)")
            }
        }
    }
    
    func getTaskById (id: NSManagedObjectID) -> SavedSneaker? {
        do {
            return try context.existingObject(with: id) as? SavedSneaker
        } catch {
            return nil
        }
    }
    
    func deleteSneaker (savedSneaker: SavedSneaker) {
        context.delete(savedSneaker)
        try? context.save()
    }
}
