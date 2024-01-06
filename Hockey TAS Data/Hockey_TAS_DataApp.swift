//
//  Hockey_TAS_DataApp.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI
import SwiftData

@main
struct Hockey_TAS_DataApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [Teams.self])
    }
}
