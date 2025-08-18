//
//  NewsService.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 14/8/25.
//

// NewsService.swift
import Foundation

class NewsService: NewsServiceProtocol {
    private let apiKey: String
    private let baseUrl: String
    private let networkService: NetworkServiceProtocol
    
    init(apiKey: String = APIConfig.newsAPIKey,
         baseUrl: String = "https://newsapi.org/v2/top-headlines",
         networkService: NetworkServiceProtocol = URLSession.shared) {
        self.apiKey = apiKey
        self.baseUrl = baseUrl
        self.networkService = networkService
    }
    
    func fetchTopHeadlines(category: String? = nil, query: String? = nil, country: String = "us") async throws -> [Article] {
        guard !apiKey.isEmpty else {
            throw NetworkError.apiKeyMissing
        }

        var components = URLComponents(string: baseUrl)
        var queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "country", value: country)
        ]

        if let category = category {
            queryItems.append(URLQueryItem(name: "category", value: category))
        }
        
        if let query = query {
            queryItems.append(URLQueryItem(name: "q", value: query))
        }

        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw NetworkError.badURL
        }

        do {
            let (data, response) = try await networkService.fetchData(from: url)

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.invalidResponse
            }

            let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
            return newsResponse.articles
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError(decodingError)
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
}
