//
//  DefaultButton.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import SwiftUI

struct DefaultButton: View {
    let text: String
    let action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text(text)
                .font(.callout)
                .fontWeight(.bold)
                .foregroundStyle(Color.theme.primaryTextColor)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.theme.primaryColor)
                .shadow(radius: 2, y: 2)
        )
    }
}

#Preview {
    DefaultButton(text: "Расписание", action: {})
}
