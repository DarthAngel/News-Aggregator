//
//  NetworkError.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 10/8/25.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
    case apiKeyMissing
}
