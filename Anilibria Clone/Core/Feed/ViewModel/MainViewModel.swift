//
//  FeedViewModel.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var articles = [Article]()
    @Published var errorMessage: String?
    @Published var status: StandardListStatus = .initial
    @Published var searchText: String = ""
    @Published var searchResult = [Article]()
    
    private var page = 0
    
    private let service = UpdatesService()
    
    private let searchService = SearchService()
    
    func handleRefresh () {
        articles.removeAll()
        fetchArticles()
    }
    
    func resultSearch() {
        searchService.searchfs(text: searchText) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let searchResult):
                        self.searchResult = searchResult.list
                        self.status = .loaded
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.status = .error
                }
            }
        }
    }
    
    func fetchArticles() {
        guard status != .loading else { return }
        status = .loading
        self.page += 1
        service.fetchUpdates(page: page) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    let existingIDs = Set(self.articles.map(\.id))
                    let filtered = articles.list.filter { !existingIDs.contains($0.id) }
                    self.articles.append(contentsOf: filtered)
                    self.status = .loaded
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.status = .error
                }
            }
        }
    }

}
