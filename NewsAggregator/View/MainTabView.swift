//
//  MainTabView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI


struct MainTabView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("News", systemImage: "newspaper")
                }
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            SavedArticlesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            
        }
    }
}

#Preview {
    MainTabView()
}
