//
//  BusinessTitle.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/16/21.
//

import SwiftUI

struct BusinessTitle: View {
    
    var business:Business
    
    var body: some View {
        
        VStack(alignment:.leading) {
            // business name
            Text(business.name!)
                .font(.title2)
                .bold()
                
            
            // loop through display address
            if business.location?.displayAddress != nil {
                
                ForEach(business.location!.displayAddress!, id:\.self) { addressline in
                    Text(addressline)
                        
                }
            }
            
            // rating
            Image("regular_\(business.rating ?? 0)")
                
            
        }
    }
}
