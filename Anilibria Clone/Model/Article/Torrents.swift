//
//  Torrents.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct Torrents: Codable {
    let episodes: Episodes?
    let list: [TorrentsList?]?
}

struct TorrentsList: Codable {
    let torrentId: Int?
    let episodes: Episodes?
    let quality: Quality?
    let leechers: Int?
    let seeders: Int?
    let downloads: Int?
    let totalSize: Int?
    let sizeString: String?
    let url: String?
    let magnet: String?
    let uploadTimestamp: Int?
    let hash: String?
    let metadata: String?
    let rawBase64File: String?
    
    enum CodingKeys: String, CodingKey {
        case episodes, quality, leechers, seeders, downloads, url, magnet, hash, metadata
        case torrentId = "torrent_id"
        case totalSize = "total_size"
        case sizeString = "size_string"
        case uploadTimestamp = "uploaded_timestamp"
        case rawBase64File = "raw_base64_file"
    }
}

struct Quality: Codable {
    let string: String?
    let type: String?
    let resolution: String?
    let encoder: String?
    let lqAudio: String?
    
    enum CodingKeys: String, CodingKey {
        case string, type, resolution, encoder
        case lqAudio = "lq_audio"
    }
}
