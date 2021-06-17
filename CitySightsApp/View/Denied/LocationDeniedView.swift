//
//  LocationDeniedView.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/17/21.
//

import SwiftUI

struct LocationDeniedView: View {
    
    let backgroundColor = Color(red: 34/255, green: 141/255, blue: 138/255)
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Spacer()
            
            Text("Whoops!")
                .font(.title)
            
            Text("We need to access your location to provide you with the best sights in the city. You can change your decision at any time in the Settings.")
            
            Spacer()
            
            Button(action: {
                
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    
                    // if we can open this settings url, then open it
                    if UIApplication.shared.canOpenURL(url) {
                        
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                
            }, label: {
                
                ZStack {
                    
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height:48)
                        .cornerRadius(10)
                    
                    Text("Go to Settings")
                        .bold()
                        .foregroundColor(backgroundColor)
                }
                
            })
            
            Spacer()
        }
        .padding()
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .background(backgroundColor)
        .ignoresSafeArea()
    
    }
}

struct LocationDeniedView_Previews: PreviewProvider {
    static var previews: some View {
        LocationDeniedView()
    }
}
