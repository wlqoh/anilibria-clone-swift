//
//  SearchService.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import Foundation

class SearchService: BaseService {
    
    func searchfs(text: String, completion: @escaping (Result<Welcome, Error>) -> Void) {
        let url = "title/search?search=\(text)"
        fetchData(url, responseType: Welcome.self, completion: completion)
    }
}
