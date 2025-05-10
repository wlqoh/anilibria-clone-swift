//
//  Youtube.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import Foundation

struct Youtube: Identifiable, Codable {
    let id: Int
    let title: String
    let preview: YoutubePreview
    let youtubeId: String
    let comments: Int
    let views: Int
    let timestamp: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, preview, comments, views, timestamp
        case youtubeId = "youtube_id"
    }
}

struct WelcomeYoutube: Codable {
    let list: [Youtube]
    let pagination: Pagination
}

struct YoutubePreview: Codable {
    let src: String
    let thumbnail: String
}
