//
//  Categories.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 01.05.2022.
//

import Foundation


enum Categories : String, CaseIterable {
    case all = "All"
    case converse = "Converse"
    case nike = "Nike"
    case jordan = "Jordan"
    case reebok = "Reebok"
    case adidas = "Adidas"
    
    
    var description : String {
        switch self {
        case .all: return "All"
        case .converse: return "Converse"
        case .nike: return "Nike"
        case .jordan: return "Jordan"
        case .reebok: return "Reebok"
        case .adidas: return "adidas"
        }
    }
}
