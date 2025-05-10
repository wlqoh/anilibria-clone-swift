//
//  SeriesPicker.swift
//  AnilibriaClone
//
//  Created by Мурад on 21/4/25.
//

import SwiftUI
import AVKit

struct SeriesPicker: View {
    let list: [String: ArticleList]
    @Binding var selected: String
    @Binding var showModal: Bool
    let action: () -> Void
    
    var body: some View {
        ModalView(content: content) {
            showModal = false
        }
    }
    
    private var content: some View {
        VStack(spacing: 0) {
            ForEach(Array(list.sorted(by: {Int($0.key)! < Int($1.key)!})), id: \.key) {key, value in
                HStack() {
                    Text("\(key).")
                    Text(list[key]?.name ?? "")
                    
                    Spacer()
                    
                    if selected == key {
                        Image(systemName: "checkmark")
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
                .foregroundStyle(.white)
                .background(Color(.systemGray2))
                .onTapGesture {
                    if selected != key {
                        selected = key
                        action()
                    }
                    withAnimation {
                        showModal = false
                    }
                }
                
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
