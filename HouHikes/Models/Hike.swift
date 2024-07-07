//
//  Hike.swift
//  HouHikes
//
//  Created by Jorge Pinto on 7/7/24.
//

import Foundation

struct Hike: Identifiable, Hashable {
    var id = UUID()
    let name: String
    let photo: String
    let miles: Double
}
