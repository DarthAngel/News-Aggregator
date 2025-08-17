//
//  ArticleRowWrapperView.swift
//  NewsAggregator
//
//  Created by Angel Docampo on 17/8/25.
//

import SwiftUI

struct ArticleRowWrapperView: View {
    @State private var viewModel: ArticleRowViewModel
    
    init(viewModel: ArticleRowViewModel) {
        self._viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ArticleRowView(viewModel: viewModel)
    }
}

//#Preview {
//    ArticleRowWrapperView()
//}
