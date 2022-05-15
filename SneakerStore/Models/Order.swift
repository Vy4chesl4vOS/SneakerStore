//
//  Order.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 07.05.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Order : Identifiable, Decodable {
    @DocumentID var id: String?
    let timestamp: Timestamp
    let totalPrice: Int
    let status: String
    let longitude: Double
    let latitude: Double
    var sneakers: [OrderSneakers]?
}

struct OrderSneakers : Identifiable ,Decodable {
    @DocumentID var id: String? 
    let name: String
    let imageUrl: String
    let price: Int
    let count: Int
}
