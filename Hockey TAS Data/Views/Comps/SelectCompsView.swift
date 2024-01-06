//
//  SelectCompsView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI

struct SelectCompsView: View {
    @Binding var searching: Bool
    @Binding var comps: [Competitions]
    @Binding var selectedWeek: Int
    var body: some View {
        ZStack {
            Color.white
            VStack {
                VStack {
                    HStack {
                        Text("Select your competitions")
                            .foregroundStyle(Color.white)
                            .fontWeight(.semibold)
                        Spacer()
                        Image("AppLogo")
                            .resizable()
                            .frame(width: 45, height: 45)
                        Image("AppText")
                            .resizable()
                            .frame(width: 68, height: 25)
                    }
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color("DarkColor1"))
                }
                .shadow(color: Color("DarkColor1"), radius: 5)
                List {
                    OutlineGroup(comps, children: \.items) { row in
                        if (row.items?.isEmpty ?? true) {
                            Text(row.name)
                                .foregroundStyle(Color("DarkColor1"))
                                .font(.footnote)
                                .frame(height: 10)
                                .listRowBackground(Color.white.opacity(0.5))
                        } else {
                            HStack {
                                Image(systemName: row.isSelected ? "checkmark.circle.fill" : "x.circle")
                                    .foregroundStyle(Color(row.isSelected ? .green : .red))
                                Text(row.name)
                                    .foregroundStyle(Color("DarkColor1"))
                            }
                            .onTapGesture {
                                row.isSelected.toggle()
                                comps = comps.map {
                                    competition in Competitions(name: competition.name, nameID: competition.nameID, isSelected: competition.isSelected, items: competition.items)
                                }
                                
                            }
                            .contentTransition(.symbolEffect(.replace))
                        }
                    }
                    .listRowBackground(Color.white)
                }
                .scrollContentBackground(.hidden)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color("DarkColor1").opacity(0.25), Color("DarkColor2").opacity(0.25)]),
                    startPoint: .top, endPoint: .bottom ))
                .padding(.vertical, -8)
                VStack {
                    Text("Select week to search for teams")
                        .foregroundStyle(Color.white)
                    Picker("Select week to search for teams:", selection: $selectedWeek) {
                        ForEach(1..<11, id: \.self) {number in
                            Text("\(number)")
                        }
                    }
                    .pickerStyle(.palette)
                    Button(action: {
                        searching = true
                    }, label: {
                        Text("Search competitions")
                            .frame(width: 220, height: 40)
                            .background(Color("AccentColor").gradient)
                            .foregroundStyle(Color("DarkColor2"))
                            .fontWeight(.semibold)
                            .cornerRadius(10.0)
                    })
                }
                .background(Color("DarkColor2"))
                .shadow(color: Color("DarkColor2"), radius: 5)
            }
            
        }
        .task {
            comps = await getComps()
        }
    }
}

#Preview {
    SelectCompsView(searching: .constant(true), comps: .constant([]), selectedWeek: .constant(1))
}
