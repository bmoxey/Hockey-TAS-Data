//
//  Classes.swift
//  Hockey TAS Data
//
//  Created by Brett Moxey on 3/1/2024.
//

import Foundation

var url = "https://www.hockeytasmania.com.au/"

class Competitions: Identifiable, ObservableObject, Equatable {
    static func == (lhs: Competitions, rhs: Competitions) -> Bool {
        lhs.name < lhs.name
    }
    
    let id = UUID()
    let name: String
    let nameID: String
    @Published var isSelected: Bool
    var items: [Competitions]?
    
    init(name: String, nameID: String, isSelected: Bool, items: [Competitions]? = nil) {
        self.name = name
        self.nameID = nameID
        self.isSelected = isSelected
        self.items = items
    }
}
