//
//  ShopLocationViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 04.05.2022.
//

import Foundation
import MapKit

class ShopLocationViewModel: ObservableObject {
    @Published var currentMapRegion: MKCoordinateRegion
    @Published var currentLocation: Location
    
    var locations = Location.locations
    let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
    
    init () {
        self.currentLocation = locations.first!
        self.currentMapRegion = MKCoordinateRegion(center: locations.first!.coordintaes, span: span)
    }
    
    func nextLocation () {
        self.currentLocation = currentLocation.name == "Shop #1" ? locations[1] : locations[0]
        self.currentMapRegion =  MKCoordinateRegion(center: currentLocation.coordintaes, span: span)
    }
    
}
