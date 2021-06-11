//
//  HomeView().swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/10/21.
//

import SwiftUI

struct HomeView: View {
    
    @State var isMapShowing = false
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // determine if we should show list or map
                if !isMapShowing {
                    
                    VStack {
                        HStack{
                            Image(systemName: "location")
                            Text("San Francisco")
                            Spacer()
                            Text("Switch to map view")
                        }
                        
                        Divider()
                        
                        // show business list view
                        BusinessList()
                    }.padding([.horizontal, .top])
                    .navigationBarHidden(true)
                    
                    
                    
                } else {
                    // show map
                }
            }
            
            
        } else {
            // show progress spinner
            ProgressView()
        }
    }
}

//struct HomeViewPreviews: PreviewProvider {
//    static var previews: some View {
//        HomeView()
//    }
//}
