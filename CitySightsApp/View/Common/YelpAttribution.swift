//
//  YelpAttribution.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/17/21.
//

import SwiftUI

struct YelpAttribution: View {
    
    var link:String
    
    var body: some View {
        
        Link(destination: URL(string: link)!, label: {
            
            Image("yelp")
                .resizable()
                .scaledToFit()
                .frame(height: 36)
            
        })
    }
}


