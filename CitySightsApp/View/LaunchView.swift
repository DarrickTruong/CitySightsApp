//
//  ContentView.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/8/21.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        // if authorization not determined, show onboarding
        if model.authorizationState == .notDetermined {
            
        }
        
        // if authorization, always or whenusing, show homeview
        else if model.authorizationState == .authorizedAlways || model.authorizationState == .authorizedWhenInUse {
            HomeView()
        }
        
        // if denied, show denied view
        else {
            
        }
        
        
    }
}
//
//struct LaunchView_Previews: PreviewProvider {
//    static var previews: some View {
//        LaunchView()
//    }
//}
