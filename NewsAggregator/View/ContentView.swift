//
//  ContentView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        TabView {
            NewsView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            SavedArticlesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            
        }
    }
}

#Preview {
    ContentView()
}
