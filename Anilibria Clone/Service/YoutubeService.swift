//
//  YoutubeService.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import Foundation

class YoutubeService: BaseService {
    private var page = 0
    
    func fetchYoutube(page: Int,completion: @escaping (Result<WelcomeYoutube, Error>) -> Void) {
        let url = "youtube?limit=5&page=\(page)"
        fetchData(url, responseType: WelcomeYoutube.self, completion: completion)
    }
}
