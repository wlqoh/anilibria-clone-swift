//
//  BaseService.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import Foundation

class BaseService {
    
    let baseURL = "https://api.anilibria.tv/v3/"
    
    func fetchData<T: Decodable>(_ urlString: String, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: baseURL + urlString) else {
                    print("DEBUG: Invalid URL")
                    return
                }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                print("DEBUG: No data returned from API")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedData))
            } catch {
                print("DEBUG: Failed to decode: \(error)")
                completion(.failure(error))
            }
        }.resume()
    }
}
