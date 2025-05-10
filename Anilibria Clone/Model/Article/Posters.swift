//
//  Posters.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct Posters: Codable {
    let small, medium, original: PosterSize?
}

struct PosterSize: Codable {
    let url: String?
    let rawBase64File: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case rawBase64File = "raw_base64_file"
    }
}
