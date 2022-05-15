//
//  OrderService.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 08.05.2022.
//

import Foundation
import Firebase

class OrderService  {
    
    func storeOrder (totalPrice: Int, status: String, longitude: Double, latitude: Double, sneakers: [OrderSneakers]) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let data = ["timestamp": Timestamp(), "totalPrice": totalPrice, "status" : status, "longitude" : longitude, "latitude": latitude] as [String: Any]
        //To user
        let docuemntId = "\(longitude)\(totalPrice)"
        Firebase.Firestore.firestore().collection("users").document(uid).collection("orders").document(docuemntId).setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for sneaker in sneakers {
                let data = ["imageUrl": sneaker.imageUrl, "price": sneaker.price, "count": sneaker.count, "name": sneaker.name] as [String: Any]
                Firebase.Firestore.firestore().collection("users").document(uid).collection("orders").document(docuemntId).collection("sneakers").document().setData(data)
            }
        }
        
        // To admin
        Firebase.Firestore.firestore().collection("orders").document("user\(uid)").setData(data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            for sneaker in sneakers {
                let data = ["imageUrl": sneaker.imageUrl, "price": sneaker.price, "count": sneaker.count, "name": sneaker.name] as [String: Any]
                Firebase.Firestore.firestore().collection("orders").document("user\(uid)").collection("sneakers").document().setData(data)
            }
        }
        
    }
    
    func fetchHistory (completion: @escaping([Order]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let path = Firebase.Firestore.firestore().collection("users").document(uid).collection("orders").order(by: "timestamp", descending: true)
        path.getDocuments { snapshot, _ in
            var orders = [Order]()
            guard let documents = snapshot?.documents else { return }
            orders = documents.compactMap{try? $0.data(as: Order.self)}
            completion(orders)
        }
    }
    
    func fetchSneakers (longitude: String, totalPrice: String ,completion: @escaping([OrderSneakers]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let docuemntId = "\(longitude)\(totalPrice)"
        Firebase.Firestore.firestore().collection("users").document(uid).collection("orders").document(docuemntId).collection("sneakers")
            .getDocuments { snapshot, _ in
                var sneakers = [OrderSneakers]()
                guard let documents = snapshot?.documents else { return }
                sneakers = documents.compactMap{try? $0.data(as: OrderSneakers.self)}
                completion(sneakers)
            }
    }
    
}
