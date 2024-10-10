//
//  ContentView.swift
//  TouristPlaceSwiftUI
//
//  Created by Joshua on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentPage = 0
    @State private var searchText = "" 

    let images = ["eiffel_tower", "great_wall_of_china", "India Gate", "Mysore Palace", "taj-Mahal"]
    let placeDetais = [
        ("eiffel_tower", "Eiffel Tower", "Paris, France"),
        ("great_wall_of_china", "Great Wall of China", "China"),
        ("India Gate", "India Gate", "New Delhi, India"),
        ("Mysore Palace", "Mysore Palace", "Karnataka, India"),
        ("taj-Mahal", "Taj Mahal", "Agra, India"),("eiffel_tower", "Eiffel Tower", "Paris, France"),
        ("great_wall_of_china", "Great Wall of China", "China"),
        ("India Gate", "India Gate", "New Delhi, India"),
        ("Mysore Palace", "Mysore Palace", "Karnataka, India"),
        ("taj-Mahal", "Taj Mahal", "Agra, India")
    ]
    let listData = ["apple", "banana", "orange", "blueberry"]

    @State private var showBottomSheet = false
    @State private var topCharacters: [(String, Int)] = []

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    TabView(selection: $currentPage) {
                        ForEach(0..<images.count, id: \.self) { index in
                            Image(images[index])
                                .resizable()
                                .scaledToFill()
                                .frame(height: 200)
                                .cornerRadius(15)
                                .padding(.horizontal, 15)
                                .clipped()
                                .tag(index)
                        }
                    }
                    .frame(height: 200) // Adjust height as needed
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                    PageControl(currentPage: $currentPage, totalPages: images.count)
                        .padding(.bottom, 20)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search...", text: $searchText)
                            .padding(8)
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)

                    VStack {
                        // Show filtered items based on search text
                        ForEach(filteredPlaceDetails, id: \.0) { data in
                            HStack {
                                Image(data.0)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())

                                VStack(alignment: .leading) {
                                    Text(data.1)
                                        .font(.headline)
                                    Text(data.2)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal)
                        }
                    }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showBottomSheet = true
                        topCharacters = StringUtils.calculateTopCharacters(from: listData)
                    }) {
                        Image("dots")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 50, height: 50)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                }
            }
        }
        // Bottom Sheet
        .sheet(isPresented: $showBottomSheet) {
            StatisticsBottomSheet(listData: listData, topCharacters: topCharacters)
        }
    }

    // Filter `placeDetais` based on the search text
    var filteredPlaceDetails: [(String, String, String)] {
        if searchText.isEmpty {
            return placeDetais
        } else {
            return placeDetais.filter {
                $0.1.lowercased().contains(searchText.lowercased()) ||
                $0.2.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

// Bottom Sheet View
struct StatisticsBottomSheet: View {
    let listData: [String]
    let topCharacters: [(String, Int)]

    var body: some View {
        VStack(spacing: 20) {
            Text("Statistics")
                .font(.title)
                .padding(.top)

            Text("List 1 (\(listData.count) items)")
                .font(.headline)

            ForEach(topCharacters, id: \.0) { character, count in
                Text("\(character) = \(count)")
            }

            Spacer()
        }
        .padding()
    }
}

struct PageControl: View {
    @Binding var currentPage: Int
    var totalPages: Int

    var body: some View {
        HStack {
            ForEach(0..<totalPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color.blue : Color.gray)
                    .frame(width: 8, height: 8)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
