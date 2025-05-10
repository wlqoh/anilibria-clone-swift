//
//  ArticleCard.swift
//  AnilibriaClone
//
//  Created by Мурад on 6/4/25.
//

import SwiftUI
import Kingfisher

struct ArticleCard: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let imageUrl = article.posters?.original?.url {
                ImageLoader(imageUrl: Constants.imageUrl + imageUrl)
                    .frame(width: 90, height: 130, alignment: .leading)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 6, bottomLeadingRadius: 6))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Text(article.names?.ru ?? "No Name")
                    .font(.caption)
                    .fontWeight(.bold)
                    .layoutPriority(2)
                
                Text(article.description ?? "No Description")
                    .font(.caption2)
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .layoutPriority(1)
            }
            .padding(.vertical, 5)
            .padding(.trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(Color.theme.primaryColor)
                .shadow(radius: 2, y: 2)
        )
        .frame(maxWidth: .infinity)
        .frame(height: 130)
    }
}

//#Preview {
//    ArticleCard()
//}
