//
//  VideoHeader.swift
//  AnilibriaClone
//
//  Created by Мурад on 8/5/25.
//

import SwiftUI

struct VideoHeader: View {
    let name: String
    let onClose: () -> Void
    var body: some View {
        HStack {
            Text(name)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                onClose()
            } label: {
                Image(systemName: "xmark")
            }
            .foregroundStyle(.white)
        }
    }
}

