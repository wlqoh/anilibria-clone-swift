//
//  Blocked.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct Blocked: Codable {
    let copyrights: Bool?
    let geoip: Bool?
    let geoipList: [String?]?
    
    enum CodingKeys: String, CodingKey {
        case copyrights
        case geoip
        case geoipList = "geoip_list"
    }
}
