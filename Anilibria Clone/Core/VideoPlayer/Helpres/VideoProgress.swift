//
//  VideoProgress.swift
//  AnilibriaClone
//
//  Created by Мурад on 8/5/25.
//

import SwiftUI

struct VideoProgress: View {
    @ObservedObject var vm: VideoPlayerViewModel
    @GestureState var isDragging: Bool
    let onPressed: () -> Void
    
    var body: some View {
        HStack(spacing: 15) {
            if let time = vm.player?.currentTime().seconds {
                Text(String(Int(time).formatSeconds()))
                    .frame(width: 50)
                    .font(.footnote)
                    .foregroundStyle(.gray)
            }
            
            VideoSeekerView(vm: vm, isDragging: isDragging)
            
            if let duration = vm.player?.currentItem?.duration.seconds {
                if !duration.isNaN {
                    Text(String(Int(duration - vm.player!.currentTime().seconds).formatSeconds()))
                        .frame(width: 50)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                } else {
                    Text("00:00")
                        .frame(width: 50)
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
            }
            
            Button {
                withAnimation(.easeInOut(duration: 0.3)) {
                    onPressed()
                }
            } label: {
                Image(systemName: "gear")
                    .foregroundStyle(.white)
            }
        }
    }
}
