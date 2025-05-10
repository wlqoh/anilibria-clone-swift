//
//  AnimeList.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct ArticleList: Codable {
    let episode: Int?
    let name, uuid: String?
    let createdTimestamp: Int?
    let preview: String?
    let skips: Skips?
    let hls: HLS?
    
    enum CodingKeys: String, CodingKey {
        case episode, name, uuid
        case createdTimestamp = "created_timestamp"
        case preview, skips, hls
    }
}

struct HLS: Codable {
    let fhd, hd: String?
    let sd: String
    
    func avialableQuality() -> [VideoQuality: String] {
        [.fhd: fhd, .hd: hd, .sd: sd].compactMapValues { $0 }
    }
    
    func getHighestQuality() -> [VideoQuality: String] {
        
        if let fhd = fhd {
            return [.fhd: fhd]
        } else if let hd = hd {
            return [.hd: hd]
        } else {
            return [.sd: sd]
        }
    }
}

// MARK: - Skips
struct Skips: Codable {
    let opening: [Int?]?
    let ending: [Int?]?
}
