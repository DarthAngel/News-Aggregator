//
//  LoadingState.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 10/8/25.
//

import Foundation

enum LoadingState {
    case idle
    case loading
    case success
    case failed(Error)
}
