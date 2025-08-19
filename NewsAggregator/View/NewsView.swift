//
//  NewsView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(NewsViewModel.categories, id: \.self) { category in
                            Button(action: {
                                viewModel.selectedCategory = category
                                Task {
                                    await viewModel.fetchArticles()
                                }
                            }) {
                                Text(category.capitalized)
                            }
                            .modifier(ButtonSmallModifier())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }
                
                Group {
                    switch viewModel.loadingState {
                    case .idle:
                        Text("Select a category to load news")
                    case .loading:
                        List {
                            ForEach(0..<5) { _ in
                                SkeletonArticleRowView()
                            }
                        }
                        .listStyle(.plain)
                        .redacted(reason: .placeholder)
                    case .success:
                        List(viewModel.articles) { article in
                            ArticleRowWrapperView(viewModel: ArticleRowViewModel(article: article, modelContext: modelContext))
                        }
                        .listStyle(.plain)
                        .refreshable {
                            await viewModel.fetchArticles()
                        }
                    case .failed(let error):
                        VStack {
                            Text("Error loading news: \(viewModel.errorMessage ?? error.localizedDescription)")
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                            Button("Try again") {
                                Task {
                                    await viewModel.fetchArticles()
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
            }
            .navigationTitle("News Aggregator")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if case .idle = viewModel.loadingState {
                    Task {
                        await viewModel.fetchArticles()
                    }
                }
            }
        }
    }
}


#Preview {
    NewsView()
}


