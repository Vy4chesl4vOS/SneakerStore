//
//  CartListViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import CoreData


class CartListViewModel: NSObject, ObservableObject {
    private var fetchResultController: NSFetchedResultsController<SavedSneaker>
    private(set) var context: NSManagedObjectContext
    
    
    @Published var sneakers: [SavedSneakerModel] = []
    
    override init () {
        self.context = CoreDataManager.shared.context
        self.fetchResultController = NSFetchedResultsController(fetchRequest: SavedSneaker.all, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        super.init()
        fetchResultController.delegate = self
        do {
            try fetchResultController.performFetch()
            guard let savedSneakers = fetchResultController.fetchedObjects else { return }
            self.sneakers = savedSneakers.map(SavedSneakerModel.init)
        } catch {
            print(error)
        }
    }
    
    func computeTotalPrice () -> Int16 {
            let totalPrice = sneakers.reduce(0, {$0 + $1.price * $1.count})
            return totalPrice
    }
    
    func deleteSneaker (sneaker: SavedSneakerModel) {
        let id = sneaker.id
        guard let sneaker = CoreDataManager.shared.getTaskById(id: id) else { return }
        CoreDataManager.shared.deleteSneaker(savedSneaker: sneaker)
    }
    
    func deleteAll () {
        do {
            guard let items = fetchResultController.fetchedObjects else { return }

            for item in items {
                context.delete(item)
            }
            try context.save()

        } catch {

        }
    }
}

extension CartListViewModel : NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let savedSneakers = fetchResultController.fetchedObjects else { return }
        self.sneakers = savedSneakers.map(SavedSneakerModel.init)
    }
}
