//
//  ContentView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var teams: [Teams]
    @State var stillLoading: Bool = false
    var body: some View {
        if teams.isEmpty || stillLoading {
            GetCompsView(stillLoading: $stillLoading)
        } else {
            MainMenuView()
        }
    }
}

#Preview {
    ContentView()
}
