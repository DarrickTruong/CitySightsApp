//
//  BusinessMap.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/16/21.
//

import SwiftUI
import MapKit

struct BusinessMap: UIViewRepresentable {
    
    @EnvironmentObject var model:ContentModel
    
    var locations: [MKPointAnnotation] {
        
        var annotations = [MKPointAnnotation]()
        
        // create a set of annotations from our list of businesses
        for business in model.restaurants + model.sights {
            
            // if business has lat/long, create an MKPointAnnotation for it
            if let lat = business.coordinates?.latitude, let long = business.coordinates?.longitude {
                
                // create a new annotation
                let a = MKPointAnnotation()
                a.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                a.title = business.name ?? ""
                
                annotations.append(a)
            }
        }
            
        return annotations
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let mapView = MKMapView()
        
        // make user show up on map
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .followWithHeading
                
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        // remove all annotatios
        uiView.removeAnnotations(uiView.annotations)
        
        // add the ones based on the business
//        uiView.addAnnotations(self.locations)
        uiView.showAnnotations(self.locations, animated: true)
    }
    
    static func dismantleUIView(_ uiView: MKMapView, coordinator: ()) {
        uiView.removeAnnotations(uiView.annotations)
    }
}

//struct BusinessMap_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessMap()
//    }
//}
