//
//  BusinessSection.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/10/21.
//

import SwiftUI

struct BusinessSection: View {
    
    var businesses = [Business]()
    var title:String
    
    var body: some View {
        
        Section(header: BusinessSectionHeader(title: title)) {
            ForEach(businesses) { business in
                Text(business.name ?? "")
                Divider()
            }
        }
    }
}

struct BusinessSection_Previews: PreviewProvider {
    static var previews: some View {
        BusinessSection()
    }
}
