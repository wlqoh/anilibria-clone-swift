//
//  ExpandableTextField.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import SwiftUI

struct ExpandableTextField: View {
    @Binding var text: String
    @FocusState var isFocused: Bool
    let onExit: () -> Void
    let onChange: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            
            TextField("Введите текст", text: $text)
                .focused($isFocused)
                .onSubmit {
                    isFocused = true
                }
                .onChange(of: text) {
                    onChange()
                }
            
            if isFocused {
                Image(systemName: "xmark")
                    .onTapGesture {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            onExit()
                        }
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isFocused = false
                            text = ""
                        }
                        
                    }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isFocused = true
                }
            }
        }
        .onDisappear {
            withAnimation(.easeInOut(duration: 0.1)) {
                isFocused = false
                text = ""
            }
        }
        .padding(10)
        .background(Color.theme.primaryColor)
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 8, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 8))
        .frame(maxWidth: isFocused ? .infinity : 20, alignment: .trailing)
        .animation(.easeOut(duration: 0.2), value: isFocused)
        .padding(.horizontal)
    }
}

#Preview {
    ExpandableTextField(text: .constant(""), onExit: {}, onChange: {})
}
