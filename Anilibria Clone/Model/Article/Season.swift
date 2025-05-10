//
//  Season.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

struct Season: Codable {
    let string: String?
    let code: Int?
    let year: Int?
    let weekDay: Int?
    
    enum CodingKeys: String, CodingKey {
        case string
        case code
        case year
        case weekDay = "week_day"
    }
}
