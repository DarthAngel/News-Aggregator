//
//  NewsAggregatorApp.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI

@main
struct NewsAggregatorApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .modelContainer(for: Article.self)
        }
    }
}
