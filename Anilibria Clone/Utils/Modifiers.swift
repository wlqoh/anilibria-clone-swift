//
//  Modifiers.swift
//  AnilibriaClone
//
//  Created by Мурад on 8/5/25.
//
import SwiftUI

struct PrimaryPlayBackButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .fontWeight(.ultraLight)
            .foregroundStyle(.white)
            .padding(15)
            .background {
                Circle()
                    .fill(.red)
            }
    }
}

struct SecondaryPlayBackButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.caption)
            .foregroundStyle(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 8)
            .background(.red)
            .mask(RoundedRectangle(cornerRadius: 20))
            .fontWeight(.bold)
    }
}
