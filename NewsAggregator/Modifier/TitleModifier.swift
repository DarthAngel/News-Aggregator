//
//  TitleModifier.swift
//  Perpetual Nautical Almanac
//
//  Created by Angel Docampo on 18/8/25.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .shadow(color: .adaptativeShadow ,radius: 3, x: 4, y: 4)
    }
}

struct SubTitleModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.body) //.font(.subheadline)  //.font(.title3)
            .shadow(color: .adaptativeShadow ,radius: 3, x: 4, y: 4)
    }
}

struct TimeModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: .adaptativeShadow ,radius: 3, x: 4, y: 4)
            .font(.subheadline)
            .padding(.horizontal, 4)
    }
}

    
