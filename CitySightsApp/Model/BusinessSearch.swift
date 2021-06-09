//
//  BusinessSearch.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/9/21.
//

import Foundation

struct BusinessSearch:Decodable {
    
    var businesses = [Business]()
    var total = 0
    var region = Region()
}

struct Region:Decodable {
    var center = Coordinate()
}
