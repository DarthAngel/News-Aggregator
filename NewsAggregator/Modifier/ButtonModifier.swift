//
//  ButtonModifier.swift
//  Perpetual Nautical Almanac
//
//  Created by Angel Docampo on 18/8/25.
//

import SwiftUI

struct ButtonModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.vertical, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Rectangle().fill(.blue))
            .cornerRadius(10)
            .opacity(0.9)
            .shadow(color: .adaptativeShadow ,radius: 3, x: 4, y: 4)
            .foregroundColor(.white)
    }
   
}

struct ButtonCancelModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .padding(.vertical, 10)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Rectangle().fill(.red))
            .cornerRadius(10)
            .opacity(0.9)
            .shadow(color: .adaptativeShadow ,radius: 3, x: 4, y: 4)
            .foregroundColor(.white)
    }
   
}

struct ButtonSmallModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(.title3)
            .padding(.all, 5)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Rectangle().fill(.blue))
            .cornerRadius(10)
            .opacity(0.9)
            .shadow(color: .adaptativeShadow ,radius: 2, x: 2, y: 2)
            .foregroundColor(.white)
    }
   
}
