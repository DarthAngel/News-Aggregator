//
//  SavedArticlesView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//


import SwiftUI
import SwiftData


struct SavedArticlesView: View {
    @Query(sort: \Article.publishedAt, order: .reverse) private var savedArticles: [Article]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationView {
            VStack {
                if savedArticles.isEmpty {
                    ContentUnavailableView("No news saved", systemImage: "heart.slash")
                } else {
                    List(savedArticles) { article in
                        ArticleRowWrapperView(viewModel: ArticleRowViewModel(article: article, modelContext: modelContext))
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Saved News")
        }
    }
}

//#Preview {
//    SavedArticlesView()
//}
