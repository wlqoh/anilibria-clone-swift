//
//  ArticleService.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

class UpdatesService: BaseService {
    
    func fetchUpdates(page: Int,completion: @escaping (Result<Welcome, Error>) -> Void) {
        let url = "title/updates?limit=20&page=\(page)"
        fetchData(url, responseType: Welcome.self, completion: completion)
    }
}
