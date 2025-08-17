//
//  Date.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 10/8/25.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm"
        return formatter.string(from: self)
    }
}
