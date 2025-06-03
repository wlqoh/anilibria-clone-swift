//
//  VideoSeekerView.swift
//  AnilibriaClone
//
//  Created by Мурад on 19/4/25.
//

import SwiftUI
import AVKit

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
            .frame(width: seekerWidth, height: 6)
            .clipShape(Capsule())
            .contentShape(Rectangle())
            .gesture (
                DragGesture(minimumDistance: 0)
                    .updating($isDragging, body: {_, out, _ in
                        out = true
                    })
                    .onChanged({ value in
                        let locationX = value.location.x
                        let calculatedProgress = min(max(locationX / seekerWidth, 0), 1)
                        
                        vm.progress = calculatedProgress
                        vm.isSeeking = true
                    })
                    .onEnded ({ _ in
                        if let duration = vm.player?.currentItem?.duration.seconds {
                            let time = CMTime(seconds: duration * vm.progress, preferredTimescale: 600)
                            vm.player?.seek(to: time)
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                vm.isSeeking = false
                            }
                        }
                    })
            )
        }
        .frame(height: 4)
    }
}
