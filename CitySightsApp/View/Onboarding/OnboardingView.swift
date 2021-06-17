//
//  OnboardingView.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/17/21.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var model:ContentModel
    @State private var tabSelection = 0
    
    private let blue = Color(red: 0/255, green: 130/255, blue: 167/255)
    private let teal = Color(red: 55/255, green: 197/255, blue: 192/255)
    
    
    var body: some View {
        
        VStack {
            // tabview
            TabView (selection: $tabSelection,
                     content:  {
                        
                        // tab 1
                        VStack(spacing: 20) {
                            Image("city2")
                                .resizable()
                                .scaledToFit()
                            Text("Welcome to City Sights")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Text("City Sights helps you find the best in the city")
                            
                        }.tag(0)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        
                        
                        
                        // tab 2
                        VStack {
                            Image("city1")
                                .resizable()
                                .scaledToFit()
                            Text("Ready to discover your city?")
                                .bold()
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            Text("We'll show you the best restaurants, venues, and more, based on your location!")
                                
                            
                        }.tag(1)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        
                        
                        // indexdisplaymode = little dots for the tabs
                     }
            ).tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .padding()
            
            // button for next page
            Button(action: {
                
                if (tabSelection == 0) {
                    tabSelection = 1
                } else {
                    // request geolocation permission
                    model.requestGeolocationPermission()
                    
                }
                
            }, label: {
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: 48)
                        .cornerRadius(10)
                    
                    Text(tabSelection == 0 ? "Next" : "Get My Location")
                }
                
            }).accentColor(tabSelection == 0 ? blue : teal)
            .padding()
            .padding(.bottom)
            
            
        }.background(tabSelection == 0 ? blue : teal)
        .ignoresSafeArea()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
