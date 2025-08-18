//
//  FrameModifier.swift
//  Perpetual Nautical Almanac
//
//  Created by Angel Docampo on 18/8/25.
//

import SwiftUI

struct FrameModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
           // .border(Color.black, width: 0.5)
            .cornerRadius(15)
            .background(.white)
            .shadow(color: .adaptativeShadow ,radius: 5, x: 2, y: 2)
    }
}



