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
    @State private var hikes = [
        Hike(name: "Memorial Park", photo: "memorial", miles: 11.2),
        Hike(name: "Terry Hershey Trail", photo: "hershey", miles: 6.5),
        Hike(name: "Brays Bayou Park", photo: "brays", miles: 3.6)
    ]
    @State private var search: String = ""
    @State private var hikesFiltered: [Hike] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 16) {
                    TextField("Enter hike name", text: $hikeName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    
                    TextField("Enter Miles of the hike route", text: $hikeMiles)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .keyboardType(.decimalPad)
                        .onSubmit {
                            hikes.append(Hike(name: hikeName, photo: "default", miles: Double(hikeMiles) ?? 0.0))
                            hikeName = ""
                            hikeMiles = ""
                            filterHikes()
                        }
                    
                    Button(action: {
                        hikes.append(Hike(name: hikeName, photo: "default", miles: Double(hikeMiles) ?? 0.0))
                        hikeName = ""
                        hikeMiles = ""
                        filterHikes()
                    }) {
                        Text("Add Hike")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
                
                List(hikesFiltered) { hike in
                    NavigationLink(value: hike) {
                        HikeCellView(hike: hike)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Hikes")
                .navigationDestination(for: Hike.self) { hike in
                    HikeDetailScreen(hike: hike)
                }
                .searchable(text: $search)
                .onChange(of: search) { _ in
                    filterHikes()
                }
            }
            .onAppear {
                hikesFiltered = hikes
            }
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

struct HikeCellView: View {
    let hike: Hike
    
    var body: some View {
        HStack {
            Image(hike.photo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(hike.name)
                    .font(.headline)
                
                Text("\(hike.miles, specifier: "%.1f") miles")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
