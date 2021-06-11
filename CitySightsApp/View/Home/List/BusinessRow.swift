//
//  BusinessRow.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/11/21.
//

import SwiftUI

struct BusinessRow: View {
    
    @ObservedObject var business:Business
    
    var distanceStr:String {
        
            return "\(String(format: "%.1f mi away", (business.distance ?? 0)/1000/1.60934))"
    }
    
    var body: some View {
        
        HStack{
            
            // image
            let uiImage = UIImage(data: business.imageData ?? Data())
            Image(uiImage: uiImage ?? UIImage())
                .resizable()
                .frame(width: 58, height: 58)
                .cornerRadius(5)
                .scaledToFit()
                
            
            // name and distance
            VStack(alignment:.leading){
                Text(business.name ?? "")
                    .bold()
                Text(distanceStr)
            }
            
            Spacer()
            
            // star rating
            VStack(alignment: .leading){
                Image("regular_\(business.rating ?? 0)")
                Text("\(business.reviewCount ?? 0) Reviews")
                    .font(.caption)
            }
        }.foregroundColor(.black)
        
        Divider()
    }
}
//
//struct BusinessRow_Previews: PreviewProvider {
//    static var previews: some View {
//        BusinessRow()
//    }
//}
