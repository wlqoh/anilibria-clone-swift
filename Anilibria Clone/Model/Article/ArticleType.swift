//
//  Type.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct ArticleType: Codable {
    let fullString: String?
    let code: Int?
    let string: String?
    let episodes: Int?
    let length: Int?
    
    enum CodingKeys: String, CodingKey {
        case fullString = "full_string"
        case code
        case string
        case episodes
        case length
    }
    
}
