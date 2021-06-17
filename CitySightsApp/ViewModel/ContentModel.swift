//
//  ContentModel.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/8/21.
//

import Foundation
import CoreLocation

class ContentModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var authorizationState = CLAuthorizationStatus.notDetermined
    @Published var restaurants = [Business]()
    @Published var sights = [Business]()
    @Published var placemark: CLPlacemark?
    
    var locationManager = CLLocationManager()
    
    override init() {
        
        // init method of NSObject
        super.init()
        
        // set content model as the delegate of the location manager
        locationManager.delegate = self
        
        // request permission from the user
//        locationManager.requestWhenInUseAuthorization() 
        
        
        
    }
    
    func requestGeolocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // MARK: locationManager delegate functions
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //set authorizationState, to be used by LaunchView
        authorizationState = locationManager.authorizationStatus
        
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
            
            
            // get the placemark of user
            let geoCoder = CLGeocoder()
            
            geoCoder.reverseGeocodeLocation(userLocation!) { (placemarks, error) in
                
                if error == nil && placemarks != nil {
                    
                    self.placemark = placemarks?.first
                }
            }
            
            // if we have the coordinates of the user, send into yelp api
            getBusinesses(category: Constants.sightsKey, location: userLocation!)
            getBusinesses(category: Constants.restaurantsKey, location: userLocation!)

        }
    }
    
    func getBusinesses(category:String, location:CLLocation) {
        
        // create URL
        // let urlString = "https://api.yelp.com/v3/businesses/search?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&categories=\(category)&limit=6"
        
        var urlComponents = URLComponents(string: Constants.apiURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "latitude", value: String(location.coordinate.latitude)),
            URLQueryItem(name: "longitude", value: String(location.coordinate.longitude)),
            URLQueryItem(name: "categories", value: category),
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
                    
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(BusinessSearch.self, from: data!)
                        
                        
                        // sort business by distance
                        var businesses = result.businesses
                        businesses.sort { (b1, b2) -> Bool in
                            return b1.distance ?? 0 < b2.distance ?? 0
                        }
                        
                        
                        // call image function for all businesses
                        for b in businesses {
                            b.getImageData()
                        }
                        
                        
                        // need this so main thread handles the published assignment
                        DispatchQueue.main.async {
                            
//                            if category == Constants.sightsKey {
//                                self.sights = result.businesses
//                            } else if category == Constants.restaurantsKey {
//                                self.restaurants = result.businesses
//                            }
                            
                            switch category {
                            case Constants.sightsKey:
                                self.sights = businesses
                            case Constants.restaurantsKey:
                                self.restaurants = businesses
                            default:
                                break
                            }
                        }
                        
                    } catch{
                        // error from decoding
                        print(error)
                    }
                }
            }
            
            // start data task
            dataTask.resume()
            
        }
    }
}
