//
//  GetComps.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import Foundation

func getComps() async -> [Competitions] {
    var myCompName = ""
    var myCompID = ""
    var comps: [Competitions] = []
    var myComp: [Competitions] = []
    var selected = false
    var lines: [String] = []
    lines = GetUrl(url: "\(url)/games/")
    for i in 0 ..< lines.count {
        if lines[i].contains("/reports/games/download/") {
            if !myComp.isEmpty {
                comps.append(Competitions(name: myCompName, nameID: myCompID, isSelected: selected, items: myComp))
            }
            myComp = []
            myCompName = lines[i-4]
            myCompID = String(lines[i].split(separator: "=")[4]).trimmingCharacters(in: .punctuationCharacters)
            selected = false
            if myCompName.contains("Senior Competition") { selected = true }
            if myCompName.contains("Midweek Competition") { selected = true }
            if myCompName.contains("Junior Competition") { selected = true }
        }
        if lines[i].contains("/games/\(myCompID)/") {
            let myDivName = String(lines[i+1])
            let myDivID = String(lines[i].split(separator: "=")[2]).trimmingCharacters(in: .punctuationCharacters)
            myComp.append(Competitions(name: myDivName, nameID: myDivID, isSelected: selected))
        }
    }
    if !myComp.isEmpty {
        comps.append(Competitions(name: myCompName, nameID: myCompID, isSelected: selected, items: myComp))
    }
    return comps
}
