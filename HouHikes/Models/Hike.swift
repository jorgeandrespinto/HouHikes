//
//  Hike.swift
//  HouHikes
//
//  Created by Jorge Pinto on 7/7/24.
//

import Foundation

struct Hike: Identifiable, Hashable, Equatable {
    var id = UUID()
    let name: String
    let photo: String
    let miles: Double
    
    init(id: UUID = UUID(), name: String, photo: String, miles: Double) {
        self.id = id
        self.name = name
        self.photo = photo
        self.miles = miles
    }
}
