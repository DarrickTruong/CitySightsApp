//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/11/21.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business:Business
    @State private var showDirections = false
    
    var body: some View {
        
        VStack (alignment:.leading){
            
            VStack (alignment:.leading, spacing:0) {
                
                GeometryReader() { geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                        
                }
                
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(height:36)
                        .foregroundColor(business.isClosed! ? .gray : .blue)
                    
                    Text(business.isClosed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .padding(.horizontal)
                }
            }
            .ignoresSafeArea()
            
            Group {
                
                HStack {
                    BusinessTitle(business: business)
                        .padding()
                    Spacer()
                    YelpAttribution(link: business.url ?? "")
                }
                    
                DashedDivider()
                    .padding(.horizontal)
                
                // phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                
                DashedDivider()
                    .padding(.horizontal)
                
                // reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                DashedDivider()
                    .padding(.horizontal)
                
                // website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                DashedDivider()
                    .padding(.horizontal)
            }
            
            Button(action: {
                // TODO: show directions
                showDirections = true
                
            }, label: {
                
                ZStack {
                    
                    Rectangle()
                        .frame(height:48)
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }).padding()
            .sheet(isPresented: $showDirections, content: {
                DirectionsView(business: business)
            })
        }
    }
}
