//
//  PlayBackControls.swift
//  AnilibriaClone
//
//  Created by Мурад on 19/4/25.
//

import SwiftUI

struct PlaybackControls: View {
    @ObservedObject var vm: VideoPlayerViewModel
    @GestureState var isDragging: Bool
    let articlePlayer: ArticlePlayer
    
    private var currentEpisode: Int { Int(vm.selectedVideo) ?? 1 }
    private var isFirstEpisode: Bool { vm.selectedVideo == String(articlePlayer.episodes.first ?? 1) }
    private var isLastEpisode: Bool { !articlePlayer.list.keys.contains("\(currentEpisode + 1)") }
    
    var body: some View {
        let nextKey = "\(currentEpisode + 1)"
        let prevKey = "\(currentEpisode - 1)"
        VStack {
            HStack (spacing: 25) {
                Button {
                    vm.updatePlayer(key: prevKey, list: articlePlayer.list)
                } label: {
                    Image(systemName: "backward.end.fill")
                }
                .primaryPlaybackButtonStyle()
                .disabled(isFirstEpisode)
                .opacity(isFirstEpisode ? 0.6 : 1)
                
                Button {
                    if vm.isFinishedPlaying {
                        vm.refreshPlayer()
                    }
                    
                    if vm.isPlaying {
                        vm.player?.pause()
                        
                        if let timeoutTask = vm.timeoutTask {
                            timeoutTask.cancel()
                        }
                    } else {
                        vm.player?.play()
                        vm.timeoutControls()
                    }
                    
                    withAnimation(.easeInOut(duration: 0.2)) {
                        vm.isPlaying.toggle()
                    }
                }
                label: {
                    Image(systemName: vm.isFinishedPlaying ? "arrow.clockwise" : (vm.isPlaying ? "pause.fill" : "play.fill"))
                }
                .scaleEffect(1.1)
                .primaryPlaybackButtonStyle()
                
                Button {
                    vm.updatePlayer(key: nextKey, list: articlePlayer.list)
                } label: {
                    Image(systemName: "forward.end.fill")
                }
                .primaryPlaybackButtonStyle()
                .disabled(isLastEpisode)
                .opacity(isLastEpisode ? 0.6 : 1)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .opacity(vm.showPlayerControls && !isDragging ? 1 : 0)
        .animation(.easeInOut(duration: 0.2), value: vm.showPlayerControls && !isDragging)
    }
}
