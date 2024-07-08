//
//  ContentView.swift
//  HouHikes
//
//  Created by Jorge Pinto on 7/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var hikeName: String = ""
    @State private var hikeMiles: String = ""
    @State private var hikes = [Hike(name: "Memorial Park", photo: "memorial", miles: 11.2), Hike(name: "Terry Hershey Trail", photo: "hershey", miles: 6.5), Hike(name: "Brays Bayou Park", photo: "brays", miles: 3.6)]
    @State private var search: String = ""
    @State private var hikesFiltered: [Hike] = []
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Enter hike name", text: $hikeName)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                TextField("Enter Miles of the hike route", text: $hikeMiles)
                    .padding()
                    .textFieldStyle(.roundedBorder).onSubmit {
                        hikes.append(Hike(name: hikeName, photo: "default", miles: Double(hikeMiles) ?? 0.0))
                        hikeName = ""
                        hikeMiles = ""
                        filterHikes()
                    }
            }.padding()
            List(hikesFiltered) { hike in
                NavigationLink(value: hike){
                    HikeCellView(hike: hike)
                }
            }
            .navigationTitle("Hikes")
            .navigationDestination(for: Hike.self) { hike in
                HikeDetailScreen(hike: hike)
            }
            .searchable(text: $search)
            .onChange(of: search){
                filterHikes()
            }
        }
        .onAppear{
            hikesFiltered = hikes
        }
    }
    private func filterHikes() {
            if search.isEmpty {
                hikesFiltered = hikes
            } else {
                hikesFiltered = hikes.filter { $0.name.localizedCaseInsensitiveContains(search) }
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
