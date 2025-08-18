//
//  MockNetworkService.swift
//  NewsAggregatorTests
//
//  Created by Angel Docampo on 18/8/25.
//

import Foundation
import XCTest
@testable import NewsAggregator

class MockNetworkService: NetworkServiceProtocol {
    var mockData: Data?
    var mockResponse: URLResponse?
    var mockError: Error?
    var lastRequestedURL: URL?
    
    func fetchData(from url: URL) async throws -> (Data, URLResponse) {
        lastRequestedURL = url
        
        if let error = mockError {
            throw error
        }
        
        guard let data = mockData, let response = mockResponse else {
            throw NSError(domain: "MockNetworkService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock data or response not set"])
        }
        
        return (data, response)
    }
}
