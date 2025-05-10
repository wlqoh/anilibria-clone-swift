//
//  YoutubeCard.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import SwiftUI
import Kingfisher

struct YoutubeCard: View {
    let youtube: Youtube
    
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ImageLoader(imageUrl: Constants.imageUrl + youtube.preview.thumbnail)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(youtube.title)
                
                HStack {
                    Image(systemName: "message")
                    Text(String(youtube.comments))
                    
                    Spacer().frame(width: 24)
                    
                    Image(systemName: "eye")
                    Text(String(youtube.views))
                    
                    Spacer()
                }
            }
            .padding()
            .background(Color.theme.secondaryBackgroundColor)
        }
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.theme.secondaryBackgroundColor)
                .shadow(radius: 8, y: 0)
        )
        .onTapGesture {
            if let url = URL(string: Constants.youtubeUrl + youtube.youtubeId) {
                openURL(url)
            }
        }
    }
}

#Preview {
    YoutubeCard(youtube: Youtube(id: 783, title: "It Takes Two Сильв и Кроули 3 КОСМОС", preview: YoutubePreview(src: "/storage/media/videos/previews/783/f2KpqPgf1UsP1Qwf.jpg", thumbnail: "/storage/media/videos/previews/783/f2KpqPgf1UsP1Qwf__45e6347793c7412b49e8fb577c1d5085.jpg"), youtubeId: "8KXQuqEEYUQ", comments: 8, views: 42, timestamp: 1742415051))
}
