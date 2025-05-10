//
//  YoutubeViewModel.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import Foundation

class YoutubeViewModel: ObservableObject {
    
    @Published var videos = [Youtube]()
    @Published var errorMessage: String?
    @Published var status: StandardListStatus = .initial
    
    private var page = 0
    
    private let service = YoutubeService()
    
    func handleRefresh() {
        videos.removeAll()
        fetchVideos()
    }
    
    func fetchVideos() {
        status = .loading
        self.page += 1
        service.fetchYoutube(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let videos):
                    self.videos.append(contentsOf: videos.list)
                    self.status = .loaded
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.status = .error
                }
            }
        }
    }
}
