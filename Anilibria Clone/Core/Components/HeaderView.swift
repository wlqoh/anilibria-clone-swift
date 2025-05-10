//
//  HeaderView.swift
//  AnilibriaClone
//
//  Created by Мурад on 12/4/25.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let leadingImageName: String?
    let trailingImageName: String?
    let leadingImageAction: () -> Void
    let trailingImageAction: () -> Void
    
    init(title: String, leadingImageName: String? = nil, trailingImageName: String? = nil, leadingImageAction: @escaping () -> Void = {}, trailingImageAction: @escaping () -> Void = {}) {
        self.title = title
        self.leadingImageName = leadingImageName
        self.trailingImageName = trailingImageName
        self.leadingImageAction = leadingImageAction
        self.trailingImageAction = trailingImageAction
    }
    
    var body: some View {
        ZStack {
            if let leadingImageName {
                Button {
                    leadingImageAction()
                } label: {
                    Image(systemName: leadingImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(title)
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.headline)
                .fontWeight(.bold)
            
            if let trailingImageName {
                Button {
                    trailingImageAction()
                } label: {
                    Image(systemName: trailingImageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(Color.theme.defaultColor)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(Color.theme.secondaryBackgroundColor)
    }
}
