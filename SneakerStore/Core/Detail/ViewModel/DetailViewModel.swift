//
//  DetailViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import CoreData


class DetailViewModel: ObservableObject {
    @Published var sneakerCount: Int16 = 1
    
    private(set) var context: NSManagedObjectContext

    
    init () {
        self.context = CoreDataManager.shared.context
    }
    
    func saveInCartList(name: String, price: Int16, imageUrl: String, completion: (Bool) -> Void) {
        let savedSneaker = SavedSneaker(context: context)
        savedSneaker.name = name
        savedSneaker.price = price
        savedSneaker.imageUrl = imageUrl
        savedSneaker.count = sneakerCount
        
        do {
            try savedSneaker.save()
            completion(true)
        } catch {
            print("error save \(error)")
            completion(false)
        }
    }
    
    func plusItem () {
        sneakerCount += 1
    }
    
    func minusItem () {
        if sneakerCount > 1 {
            sneakerCount -= 1
        }
    }
    
    
    
}
