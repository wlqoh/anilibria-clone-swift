//
//  Player.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct ArticlePlayer: Codable {
    let alternativePlayer: String?
    let host: String?
    let isRutube: Bool?
    let episodes: Episodes
    let list: [String: ArticleList]
    let rutube: Rutube?
    
    enum CodingKeys: String, CodingKey {
        case alternativePlayer = "alternative_player"
        case host
        case isRutube = "is_rutube"
        case episodes
        case list
        case rutube
    }
}

struct Rutube: Codable {
    
}
