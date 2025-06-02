//
//  YoutubeView.swift
//  AnilibriaClone
//
//  Created by Мурад on 10/4/25.
//

import SwiftUI

struct YoutubeView: View {
    @ObservedObject var viewModel: YoutubeViewModel
    @ObservedObject var appState: AppState
    
    var body: some View {
        VStack {
            HeaderView(title: "Поиск") 
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(viewModel.videos) { video in
                        YoutubeCard(youtube: video)
                            .onAppear {
                                if viewModel.status != .loading && video.id == viewModel.videos.last?.id {
                                    viewModel.fetchVideos()
                                }
                            }
                    }
                    .padding(.horizontal)
                    
                    if viewModel.status == .loading {
                        ProgressView()
                            .frame(height: 40)
                            .padding(.bottom, 30)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .overlay {
            if let error = viewModel.errorMessage {
                Text(error)
            }
        }
        .toolbarBackground(Color.white, for: .navigationBar)
        .refreshable(action: {
            viewModel.handleRefresh()
        })
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("YouTube")
                    .font(.headline)
                    .fontWeight(.bold)
            }
        }
    }
}
