//
//  DeliveViewModel.swift
//  SneakerStore
//
//  Created by Вячеслав Утешев on 06.05.2022.
//

import CoreLocation
import MapKit
import Foundation


class DeliveViewModel : NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var location: CLLocation?
    
    @Published var placeText = ""
        
    @Published var places: [MKPlacemark] = []
        
    var locationManager: CLLocationManager?
    
    let service = OrderService()
    
    
    func checkLocationManagerWork () {
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager = CLLocationManager()
            self.locationManager!.delegate = self
  //          self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        } else {
            print("Unenabled service")
        }
    }
    
    private func checkLocationAuth () {
        guard let locationManager = locationManager else { return }

        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            break
        case .denied:
            break
        case .authorizedWhenInUse, .authorizedAlways:
            self.location = locationManager.location
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuth()
    }


    
    func searchPlaces () {
        places.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = placeText
        request.pointOfInterestFilter = .includingAll
        request.resultTypes = .address

        MKLocalSearch(request: request).start { response, _ in
            guard let result = response else { return }
            self.places = result.mapItems.compactMap({$0.placemark})
            
        }
        
    }
    
    func makeOrder (totalPrice: Int, status: String, longitude: Double, latitude: Double, sneakers: [SavedSneakerModel]) {
        var orderSneaker: [OrderSneakers] = []
        for sneaker in sneakers {
            orderSneaker.append(OrderSneakers(name: sneaker.name, imageUrl: sneaker.imageUrl, price: Int(sneaker.price), count: Int(sneaker.count)))
        }
        service.storeOrder(totalPrice: totalPrice, status: status, longitude: longitude, latitude: latitude, sneakers: orderSneaker)
    }
        
}
