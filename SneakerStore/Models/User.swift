//
//  User.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 02.05.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable {
    @DocumentID var id: String?
    let email: String
    let fullname: String
}
