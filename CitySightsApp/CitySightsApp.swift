//
//  CitySightsApp.swift
//  CitySightsApp
//
//  Created by Darrick_Truong on 6/8/21.
//

import SwiftUI

@main
struct CitySightsApp
: App {
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(ContentModel())
        }
    }
}
