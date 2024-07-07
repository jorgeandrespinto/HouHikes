//
//  ContentView.swift
//  HouHikes
//
//  Created by Jorge Pinto on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    
    let hikes = [Hike(name: "Memorial Park", photo: "memorial", miles: 11.2), Hike(name: "Terry Hershey Trail", photo: "hershey", miles: 6.5), Hike(name: "Brays Bayou Park", photo: "brays", miles: 3.6)]
    
    var body: some View {
        NavigationStack{
            List(hikes) { hike in
                NavigationLink(value: hike){
                    HikeCellView(hike: hike)
                }
            }.navigationTitle("Hikes")
                .navigationDestination(for: Hike.self) { hike in
                    HikeDetailScreen(hike: hike)
                }
        }
    }
}

#Preview {
    ContentView()
}

struct HikeCellView: View {
    let hike: Hike
    var body: some View {
        HStack{
            Image(hike.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(20)
            VStack(alignment: .leading){
                Text(hike.name)
                Text("\(hike.miles.formatted()) miles")
            }
            
        }
    }
}
