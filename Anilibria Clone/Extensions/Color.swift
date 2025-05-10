//
//  Color.swift
//  AnilibriaClone
//
//  Created by Мурад on 5/5/25.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secondaryBackgroundColor = Color("SecondaryBackgroundColor")
    let primaryColor = Color("PrimaryColor")
    let primaryTextColor = Color("PrimaryTextColor")
    let defaultColor = Color("DefaultColor")
}
