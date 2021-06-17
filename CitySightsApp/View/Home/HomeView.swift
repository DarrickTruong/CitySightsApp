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
    @State var selectedBusiness:Business?
    
    var body: some View {
        
        
        if model.restaurants.count != 0 || model.sights.count != 0 {
            
            NavigationView {
                
                // determine if we should show list or map
                if !isMapShowing {
                    
                    VStack {
                        HStack{
                            Image(systemName: "location")
                            Text(model.placemark?.locality ?? "")
                            Spacer()
                            Button("Switch to map view") {
                                self.isMapShowing = true
                            }
                        }
                        
                        Divider()
                        
                        // show business list view
                        
                        ZStack(alignment:.top) {
                            BusinessList()
                            
                            HStack {
                                Spacer()
                                YelpAttribution(link: "https://yelp.com")
                            }.padding(.trailing, -20)
                        }
                    }.padding([.horizontal, .top])
                    .navigationBarHidden(true)
                    
                    
                    
                } else {
                    
                    // show map
                    ZStack (alignment:.top) {
                        BusinessMap(selectedBusiness: $selectedBusiness)
                            .ignoresSafeArea()
                            .sheet(item: $selectedBusiness) { business in
                                
                                // create a business detail view instance
                                // pass in selected business
                                BusinessDetail(business: business)
                            }
                        
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .frame(height: 48)
                            
                            HStack {
                                Image(systemName: "location")
                                Text(model.placemark?.locality ?? "")
                                Spacer()
                                Button("Switch to list view") {
                                    self.isMapShowing = false
                                }
                            }.padding()
                            
                        }.padding()
                        
                    }
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
