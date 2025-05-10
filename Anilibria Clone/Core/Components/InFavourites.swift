//
//  InFavourites.swift
//  AnilibriaClone
//
//  Created by Мурад on 9/4/25.
//

import SwiftUI

struct InFavourites: View {
    let count: Int
    var body: some View {
        HStack(alignment: .top) {
            Text(String(count))
                .fontWeight(.bold)
            
            Image(systemName: "star")
        }
        .font(.caption)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.black), lineWidth: 1)
        }
    }
}

#Preview {
    InFavourites(count: 3841)
}
