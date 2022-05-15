//
//  SavedSneaker.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import CoreData

struct SavedSneakerModel : Identifiable {
    let savedSneaker : SavedSneaker
    
    init (savedSneaker: SavedSneaker) {
        self.savedSneaker = savedSneaker
    }
    
    var id: NSManagedObjectID {
        savedSneaker.objectID
    }
    
    var name: String {
        savedSneaker.name ?? ""
    }
    
    var price: Int16 {
        savedSneaker.price
    }
    
    var imageUrl : String {
        savedSneaker.imageUrl ?? ""
    }
    
    var count : Int16 {
        savedSneaker.count
    }
}
