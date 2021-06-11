//
//  BusinessDetail.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/11/21.
//

import SwiftUI

struct BusinessDetail: View {
    
    var business:Business
    
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
                
                // business name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                
                // loop through display address
                if business.location?.displayAddress != nil {
                    
                    ForEach(business.location!.displayAddress!, id:\.self) { addressline in
                        Text(addressline).padding(.horizontal)
                    }
                }
                
                // rating
                Image("regular_\(business.rating ?? 0)")
                    .padding(.horizontal)
                
                
                Divider()
                
                // phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.displayPhone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }.padding()
                
                Divider()
                
                // reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.reviewCount ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
                
                // website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(business.url ?? "")
                        .lineLimit(1)
                    Spacer()
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }.padding()
                
                Divider()
            }
            
            Button(action: {
                
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
        }
    }
}

//struct BusinessDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessDetail()
//    }
//}
