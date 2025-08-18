//
//  NewsAggregatorTests.swift
//  NewsAggregatorTests
//
//  Created by Angel Docampo on 18/8/25.
//

import XCTest
@testable import NewsAggregator


final class NewsServiceTests: XCTestCase {
    
    var newsService: NewsServiceProtocol!
    var mockNetworkService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        newsService = NewsService(networkService: mockNetworkService)
    }
    
    override func tearDown() {
        newsService = nil
        mockNetworkService = nil
        super.tearDown()
    }
    
    func testFetchTopHeadlines_Success() async throws {
        // Given
        
        let dateFormatter = ISO8601DateFormatter()
        let publishedDate = dateFormatter.date(from: "2023-01-01T00:00:00Z")
        
        let expectedArticle = Article(
            source: Source(id: "test", name: "Test Source"),
            author: "Test Author",
            title: "Test Title",
            articleDescription: "Test Description",
            url: "https://example.com",
            urlToImage: "https://example.com/image.jpg",
            publishedAt: publishedDate,
            content: "Test Content"
        )
        
        let response = NewsResponse(
            status: "ok",
            totalResults: 1,
            articles: [expectedArticle]
        )
        
        mockNetworkService.mockData = try JSONEncoder().encode(response)
        mockNetworkService.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        
        // When
        let articles = try await newsService.fetchTopHeadlines(category: "", query: "", country: "")
        
        // Then
        XCTAssertEqual(articles.count, 1)
        XCTAssertEqual(articles[0].title, "Test Title")
        XCTAssertEqual(articles[0].author, "Test Author")
    }
    
    func testFetchTopHeadlines_WithCategory() async throws {
        // Given
        let expectedCategory = "technology"
        let response = NewsResponse(
            status: "ok",
            totalResults: 1,
            articles: []
        )
        
        mockNetworkService.mockData = try JSONEncoder().encode(response)
        mockNetworkService.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        
        // When
        _ = try await newsService.fetchTopHeadlines(category: expectedCategory, query: "", country: "")
        
        // Then
        guard let url = mockNetworkService.lastRequestedURL,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            XCTFail("Invalid URL or query items")
            return
        }
        
        XCTAssertTrue(queryItems.contains { $0.name == "category" && $0.value == expectedCategory })
    }
    
    func testFetchTopHeadlines_WithQuery() async throws {
        // Given
        let expectedQuery = "test"
        let response = NewsResponse(
            status: "ok",
            totalResults: 1,
            articles: []
        )
        
        mockNetworkService.mockData = try JSONEncoder().encode(response)
        mockNetworkService.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        
        // When
        _ = try await newsService.fetchTopHeadlines(category: "", query: expectedQuery, country: "")
        
        // Then
        guard let url = mockNetworkService.lastRequestedURL,
              let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let queryItems = components.queryItems else {
            XCTFail("Invalid URL or query items")
            return
        }
        
        XCTAssertTrue(queryItems.contains { $0.name == "q" && $0.value == expectedQuery })
    }
    
    func testFetchTopHeadlines_InvalidResponse() async {
        // Given
        
        mockNetworkService.mockData = Data()
        mockNetworkService.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 500,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        
        // When/Then
              do {
                  _ = try await newsService.fetchTopHeadlines(category: "", query: "", country: "")
                  XCTFail("Expected to throw invalidResponse error")
              } catch {
                  switch error as? NetworkError {
                  case .requestFailed(NewsAggregator.NetworkError.invalidResponse):
                      print("SUCCESS!!!!!")
                  default:
                      XCTFail("Unexpected error: \(error)")
                  }
                 
              }
    }
    
    func testFetchTopHeadlines_DecodingError() async {
        // Given
        let invalidJSON = """
        {
            "status": "ok",
            "totalResults": 1,
            "articles": [
                {
                    "title": 123,  // Invalid type, should be string
                    "description": "Test Description"
                }
            ]
        }
        """.data(using: .utf8)!
        
        mockNetworkService.mockData = invalidJSON
        mockNetworkService.mockResponse = HTTPURLResponse(
            url: URL(string: "https://example.com")!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: ["Content-Type": "application/json"]
        )
        
        // When/Then
        do {
            _ = try await newsService.fetchTopHeadlines(category: "", query: "", country: "")
            XCTFail("Expected to throw decodingError")
        } catch NetworkError.decodingError {
            // Success
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testFetchTopHeadlines_RequestFailed() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: -1, userInfo: nil)
        mockNetworkService.mockError = expectedError
        
        // When/Then
        do {
            _ = try await newsService.fetchTopHeadlines(category: "", query: "", country: "")
            XCTFail("Expected to throw requestFailed error")
        } catch let NetworkError.requestFailed(error as NSError) where error.domain == "TestError" && error.code == -1 {
            // Success
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
