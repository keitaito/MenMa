//
//  LocationManager.swift
//  MenMa
//
//  Created by Keita Ito on 1/23/16.
//  Copyright © 2016 Keita Ito. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate: class {
    func locationManagerDidReceiveLocation(location: CLLocation)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    weak var delegate: LocationManagerDelegate?
    let manager: CLLocationManager
    
    override init() {
        manager = CLLocationManager()
        super.init()
    }
    
    func startStandardUpdates() {
        
        manager.requestWhenInUseAuthorization()
        
        guard CLLocationManager.locationServicesEnabled() else { return }
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        // distanceFilter is disabled for dev.
//        manager.distanceFilter = 500
        
        manager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // If it's a relatively recent event, turn off updates to save power.
        let lastLocation = locations.last
        guard let location = lastLocation else { print("No location data"); return }
        
        // howRecent check is disabled for dev.
//        let eventDate = location.timestamp
//        let howRecent = eventDate.timeIntervalSinceNow
//        if abs(howRecent) < 15.0 {
            // If the event is recent, do something with it.
//            print("latitude: \(location.coordinate.latitude), longitude \(location.coordinate.longitude)\n")
            delegate?.locationManagerDidReceiveLocation(location)
//        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print(error.localizedDescription);
    }
    
    func urlParameter(location location: CLLocation) -> String {
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        let result = "\(latitude),\(longitude)"
        return result
    }
}
