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
        
        let userLocation = locations.first
        if userLocation != nil  {
            // have location
            
            // stop requesting the location after we get it once
            locationManager.stopUpdatingLocation()
            
            // TODO: if we have the coordinates of the user, send into yelp api
            getBusinesses(category: "arts", location: userLocation!)
            
        }
    }
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // create URL
        // let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        var urlComponents = URLComponents(string: Constants.apiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: String(category)),
            URLQueryItem(name: "limit", value: "6")
        ]
        let url = urlComponents?.url
        
        if let url = url {
            // create URL Request
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            // request header
            request.httpMethod = "GET"
            request.addValue("Bearer \(Constants.apiKey)", forHTTPHeaderField: "Authorization")
            
            // get URL session
            let session = URLSession.shared
            
            // create Data Task
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    print(response!)
                }
            }
            // start data task
            dataTask.resume()
            
        }
        
        
    }
}
