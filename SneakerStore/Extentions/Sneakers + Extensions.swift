//
//  CoreSneakers.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation



import Foundation
import CoreData

extension SavedSneaker {
    static var all: NSFetchRequest<SavedSneaker> {
        let request = SavedSneaker.fetchRequest()
        request.sortDescriptors = []
        return request
    }
    
    func save () throws {
       try? CoreDataManager.shared.context.save()
    }

}
