//
//  URLConfig.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 14/8/25.
//

import Foundation

struct URLConfig {
    static let newsAPIKey: String = {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            fatalError("Secrets.plist not found or malformed")
        }
        guard let key = dict["NewsAPIKey"] as? String else {
            fatalError("NewsAPIKey not found in Secrets.plist")
        }
        return key
    }()
}
