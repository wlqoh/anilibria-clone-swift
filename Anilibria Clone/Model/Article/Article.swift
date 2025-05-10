//
//  Updates.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct Article: Identifiable, Codable {
    let id: Int
    let code: String?
    let names: Names?
    let franchises: [Franchises]
    let announce: String?
    let status: Status?
    let posters: Posters?
    let updated: Int?
    let lastChange: Int?
    let type: ArticleType?
    let genres: [String]?
    let team: Team?
    let season: Season?
    let description: String?
    let inFavorites: Int?
    let blocked: Blocked?
    let player: ArticlePlayer
    let torrents: Torrents?
    
    enum CodingKeys: String, CodingKey {
        case id, code, names, franchises, announce, status, posters, updated, type, genres, team, season, description, blocked, player, torrents
        case lastChange = "last_change"
        case inFavorites = "in_favorites"
    }
}

struct Welcome: Codable {
    let list: [Article]
    let pagination: Pagination
}

struct Pagination: Codable {
    let pages, currentPage, itemsPerPage, totalItems: Int

    enum CodingKeys: String, CodingKey {
        case pages
        case currentPage = "current_page"
        case itemsPerPage = "items_per_page"
        case totalItems = "total_items"
    }
}

struct Schedule: Codable {
    let day: Int
    let list: [Article]
}

struct Franchises: Codable {
    
}
