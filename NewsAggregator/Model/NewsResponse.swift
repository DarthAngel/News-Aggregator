//
//  NewsResponse.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 10/8/25.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
