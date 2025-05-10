//
//  ModalView.swift
//  AnilibriaClone
//
//  Created by Мурад on 8/5/25.
//

import SwiftUI

struct ModalView<Content: View>: View {
    let content: Content
    let onExit: () -> Void
    
    var body: some View {
        VStack {
            
            
            ScrollView {
                content
            }
            .scrollIndicators(.hidden)
            .padding(5)
            .background(Color(.systemGray))
            .clipShape(RoundedRectangle(cornerRadius: 4))
            
            HStack {
                Text("Готово")
                    .padding()
            }
            .frame(width: 300)
            .background(Color(.systemGray))
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 4))
            .onTapGesture {
                withAnimation {
                    onExit()
                }
            }
        }
        .frame(width: 300)
        .background(Color.clear)
    }
}

