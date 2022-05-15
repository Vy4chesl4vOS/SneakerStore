//
//  Location.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import MapKit

struct Location : Identifiable{
    let name: String
    let adress: String
    let coordintaes: CLLocationCoordinate2D
    let workTime: String
    let imageName: String
    
    var id : String {
        name + adress
    }
    
    static let locations: [Location] = [Location(name: "Shop #1", adress: "Москва, переулок Гороховский, дом 4", coordintaes:  CLLocationCoordinate2D(latitude: 55.7636096142455, longitude: 37.662100742420684), workTime: "9:30 - 20:00", imageName: "shop1"), Location(name: "Shop #2", adress: "Санкт-Петербург, Радищева 3, дом 11а", coordintaes:  CLLocationCoordinate2D(latitude: 59.941335, longitude: 30.363615), workTime: "10:00 - 21:00", imageName: "shop2")]
    
}
