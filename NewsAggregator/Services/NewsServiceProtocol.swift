//
//  NewsServiceProtocol.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

// NetworkServiceProtocol.swift
import Foundation

protocol NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> (Data, URLResponse)
}

// Default implementation using URLSession
extension URLSession: NetworkServiceProtocol {
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        try await data(from: url)
    }
}

// MARK: - NewsService Protocol
protocol NewsServiceProtocol {
    func fetchTopHeadlines(category: String?, query: String?, country: String) async throws -> [Article]
}
