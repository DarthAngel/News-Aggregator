//
//  ArticleDetailView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI


struct ArticleDetailView: View {
    let article: Article
    
    @State private var showingSafariView = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                if let imageUrl = article.urlToImage,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray.opacity(0.1))
                    }
                }

                Text(article.title ?? "Title unavailable")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                HStack {
                    Text(article.author ?? "Unknown Author")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Text(article.source?.name ?? "Unknown Source")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                if let publishedDate = article.publishedAt {
                    Text(publishedDate.formattedDate)
                        .font(.caption)
                        .foregroundColor(.secondary)
                } else {
                    Text("Date not available")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Divider()

                Text(article.content ?? article.articleDescription ?? "No content or description available.")
                    .font(.body)
                    .padding(.bottom)
                
                if let urlString = article.url, let articleURL = URL(string: urlString) {
                    Button {
                        showingSafariView = true
                    } label: {
                        Label("Read Full Arcticle", systemImage: "safari.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            .background(Capsule().fill(Color.blue))
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $showingSafariView) {
                        SafariView(url: articleURL)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("News Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}


//#Preview {
//    ArticleDetailView()
//}
