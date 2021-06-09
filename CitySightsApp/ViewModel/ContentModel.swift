//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/8/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // request permission from the user
        locationManager.requestWhenInUseAuthorization()
        
        
        
    }
    
    // MARK: locationManager delegate functions
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse {
            
            // we have permission
            // start geolocating user
            locationManager.startUpdatingLocation()
            
        } else if locationManager.authorizationStatus == .denied {
            
            // dont have permission
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // gives us the location of the user
        print(locations.first ?? "no location")
        
        // stop requesting the location after we get it once
        locationManager.stopUpdatingLocation()
        
        // TODO: if we have the coordinates of the user, send into yelp api

        
    }
}
