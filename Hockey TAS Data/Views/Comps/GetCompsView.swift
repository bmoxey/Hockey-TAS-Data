//
//  GetCompsView.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import SwiftUI
import SwiftData

struct GetCompsView: View {
    @Environment(\.modelContext) var context
    @Query var teams: [Teams]
    @Binding var stillLoading: Bool
    @State private var searching: Bool = false
    @State private var comps: [Competitions] = []
    @State var selectedWeek = 1
    @State var totalDivs = 100.0
    @State var divsFound = 0.0
    @State var msg = "Searching..."
    var body: some View {
        if searching {
            LoadingView(current: $divsFound, maximum: $totalDivs, message: $msg)
                .task {
                    await GetTeams()
                }
        } else {
            SelectCompsView(searching: $searching, comps: $comps, selectedWeek: $selectedWeek)
        }
    }
    
    func GetTeams() async {
        stillLoading = true
        var lines: [String] = []
        var count = 0
        let selectedComps = comps.filter({ $0.isSelected })
        totalDivs = Double(selectedComps.reduce(0) { count, selectedComp in
            return count + (selectedComp.items?.count ?? 0)
        })
        for selectedComp in selectedComps {
            if let items = selectedComp.items {
                for item in items {
                    lines = GetUrl(url: "\(url)games/\(selectedComp.nameID)/&r=\(selectedWeek)&d=\(item.nameID)")
                    divsFound += 1
                    for i in 0 ..< lines.count {
                        if lines[i].contains("\(url)teams") {
                            count += 1
//                            let teamName = ShortTeamName(fullName: lines[i+1])
                            let teamName = lines[i+1]
                            let teamID = String(String(lines[i].split(separator: "=")[2]).trimmingCharacters(in: .punctuationCharacters))
                            let clubName = teamName
//                            let clubName = ShortClubName(fullName: teamName)
                            let divLevel = item.name
//                            let divLevel = GetDivLevel(fullString: item.name)
                            let divType = item.name
//                            let divType = GetDivType(fullName: item.name)
                            let team = Teams(id: Int(teamID) ?? 0, compName: selectedComp.name, compID: selectedComp.nameID, divName: item.name, divID: item.nameID, divLevel: divLevel, divType: divType, teamName: teamName, teamID: teamID, clubName: clubName, isCurrent: false, isUsed: false)
                            context.insert(team)
                            msg = "Searching... found \(count) teams"
                        }
                    }
                }
            }
        }
        if !teams.isEmpty {
            stillLoading = false
        } else {
            searching = false
        }
    }
}

#Preview {
    GetCompsView(stillLoading: .constant(true))
}
