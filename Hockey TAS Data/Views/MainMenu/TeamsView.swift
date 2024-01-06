//
//  TeamsView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI
import SwiftData

struct TeamsView: View {
    @Environment(\.modelContext) var context
    @Query var teams: [Teams]
    @Query(filter: #Predicate<Teams> {$0.isUsed}) var usedTeams: [Teams]
    @State private var showingConfirmation = false
    @State private var shouldShowNoDataView = false
    var body: some View {
        ZStack {
            Color.white
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "person.crop.circle.badge.questionmark")
                            .symbolRenderingMode(.palette)
                            .font(.system(size: 24))
                            .foregroundStyle(Color("AccentColor"),Color.white)
                        Button(action: {
                            showingConfirmation = true
                        }, label: {
                            VStack {
                                Image(systemName: "arrow.counterclockwise.icloud")
                                    .symbolRenderingMode(.palette)
                                    .foregroundStyle(Color.white, Color("AccentColor"))
                                Text("Rebuild")
                                    .font(.system(size: 12))
                                    .foregroundStyle(Color.white)
                            }
                        })
                        .alert("Are you sure?", isPresented: $showingConfirmation)
                        {
                            Button("Rebuild", role: .destructive) {
                                do {
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                    try context.delete(model: Teams.self)
                                    try context.save()
                                    shouldShowNoDataView = true
                                } catch {
                                    print("failed to delete")
                                }
                                
                            }
                            .sheet(isPresented: $shouldShowNoDataView) {
                                ContentView()
                            }
                        } message: {
                            Text("This will delete all currently selected teams and rebuild the teams list from the web site.\n\n This process will take approximately one minute.")
                        }
                        Spacer()
                        Text("Select your team")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                        Spacer()
                        Text("Add Team")
                            .font(.system(size: 15))
                            .foregroundStyle(Color("AccentColor"))
                        Image(systemName: "person.crop.circle.badge.plus")
                            .symbolRenderingMode(.palette)
                            .font(.system(size: 24))
                            .foregroundStyle(Color.white, Color("AccentColor"))
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color("DarkColor1"))
                }
                .shadow(color: Color("DarkColor1"), radius: 5)
                List {
                }
                .scrollContentBackground(.hidden)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color("DarkColor1").opacity(0.25), Color("DarkColor1").opacity(0.25)]),
                    startPoint: .top, endPoint: .bottom ))
                .padding(.vertical, -8)
                Rectangle()
                    .frame(height: 49)
            }
        }
    }
}

#Preview {
    TeamsView()
}
