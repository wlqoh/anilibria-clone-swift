//
//  ExpandableResultView.swift
//  AnilibriaClone
//
//  Created by Мурад on 23/4/25.
//

import SwiftUI

struct ExpandableResultView: View {
    var searchResult: [Article]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ForEach(searchResult) { result in
                NavigationLink {
                    DetailView(article: result)
                } label: {
                    SearchCard(article: result)
                        .padding(.horizontal)
                }
                .buttonStyle(.plain)
            }
        }
        .background(Color.theme.primaryColor)
        .frame(maxWidth: .infinity)
        
        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 8, bottomTrailingRadius: 8, topTrailingRadius: 0))
        .padding(.horizontal)
    }
}
