//
//  VideoSeekerView.swift
//  AnilibriaClone
//
//  Created by Мурад on 19/4/25.
//

import SwiftUI

struct VideoSeekerView: View {
    @ObservedObject var vm: VideoPlayerViewModel
    @GestureState var isDragging: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let seekerWidth = geometry.size.width
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(.gray)
                
                Rectangle()
                    .fill(.red)
                    .frame(width: max(seekerWidth * (vm.progress.isNaN ? 0 : vm.progress) , 0))
            }
            .frame(width: seekerWidth, height: 3)
            .overlay(alignment: .leading) {
                Circle()
                    .fill(.red)
                    .frame(width: 15, height: 15)
                    .scaleEffect(vm.showPlayerControls || isDragging ? 1 : 0.001, anchor: vm.progress * seekerWidth > 15 ? .trailing : .leading)
                    .frame(width: 50, height: 50)
                    .contentShape(Rectangle())
                    .offset(x: seekerWidth * vm.progress)
                    .gesture (
                        DragGesture()
                            .updating($isDragging, body: {_, out, _ in
                                out = true
                            })
                            .onChanged({ value in
                                
                                if let timeoutTask = vm.timeoutTask{
                                    timeoutTask.cancel()
                                }
                                
                                let translationX: CGFloat = value.translation.width
                                let calculatedProgress = (translationX / seekerWidth) + vm.lastDraggedProgress
                                
                                vm.progress = max(min(calculatedProgress, 1), 0)
                                vm.isSeeking = true
                            })
                            .onEnded ({ value in
                                
                                vm.lastDraggedProgress = vm.progress
                                
                                if let currentPlayerItem = vm.player?.currentItem {
                                    let totalDuration = currentPlayerItem.duration.seconds
                                    
                                    vm.player?.seek(to: .init(seconds: totalDuration * vm.progress, preferredTimescale: 1))
                                    
                                    if vm.isPlaying {
                                        vm.timeoutControls()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                        vm.isSeeking = false
                                    }
                                }
                            })
                    )
                    .offset(x: vm.progress * seekerWidth > 15 ? -15 : 0)
                    .frame(width: 15, height: 15)
            }
        }
        .frame(height: 1)
    }
}
