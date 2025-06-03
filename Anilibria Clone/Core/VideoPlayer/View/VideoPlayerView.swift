//
//  FullScreenVideoView.swift
//  AnilibriaClone
//
//  Created by Мурад on 19/4/25.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    @StateObject var vm = VideoPlayerViewModel()
    @GestureState var isDragging: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var showSeriesPicker: Bool = false
    @State var showAdditionalSettings: Bool = false
    @State var orientation: UIInterfaceOrientationMask = .portrait
    
    let name: String
    let articlePlayer: ArticlePlayer
    
    var body: some View {
        ZStack(alignment: .center) {
            if let player = vm.player {
                CustomVideoPlayer(player: player)
                    .overlay {
                        Rectangle()
                            .fill(.black.opacity(0.4))
                            .opacity(vm.showPlayerControls || isDragging ? 1 : 0)
                            .animation(.easeInOut(duration: 0.35), value: isDragging)
                    }
                    .overlay(alignment: .center) {
                        PlaybackControls(vm: vm, isDragging: isDragging, articlePlayer: articlePlayer)
                    }
            }
            
            VStack(alignment: .leading) {
                VideoHeader(name: name, onClose: {
                    vm.player?.pause()
                    dismiss()
                })
                .padding(.bottom)
                .opacity(vm.showPlayerControls ? 1 : 0)
                
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        showSeriesPicker = true
                    }
                } label: {
                    Label(vm.selectedVideo, systemImage: "chevron.down")
                }
                .secondaryPlaybackButtonStyle()
                .opacity(vm.showPlayerControls ? 1 : 0)
                
                Spacer()
                
                Button {
                    vm.player?.seek(to: CMTime(seconds: Double(articlePlayer.list[vm.selectedVideo]!.skips.opening.last!), preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .positiveInfinity)
                    
                } label: {
                    Text("Skip")
                }
                .font(.subheadline)
                .fontWeight(.bold)
                .frame(width: 40, height: 20)
                .foregroundStyle(.white)
                .padding(8)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(vm.isAllowedToSkip ? 1 : 0)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom)
                
                HStack(spacing: 15) {
                    Button {
                        vm.seekTo(15, isForward: false)
                    } label: {
                        Label("15", systemImage: "backward.fill")
                    }
                    .secondaryPlaybackButtonStyle()
                    
                    Button {
                        vm.seekTo(5, isForward: false)
                    } label: {
                        Label("5", systemImage: "backward.fill")
                    }
                    .secondaryPlaybackButtonStyle()
                    
                    Spacer()
                    
                    Button {
                        vm.seekTo(5, isForward: true)
                    } label: {
                        Label("5", systemImage: "forward.fill")
                    }
                    .secondaryPlaybackButtonStyle()
                    
                    Button {
                        vm.seekTo(15, isForward: true)
                    } label: {
                        Label("15", systemImage: "forward.fill")
                    }
                    .secondaryPlaybackButtonStyle()
                }
                .opacity(vm.showPlayerControls ? 1 : 0)
                
                
                VideoProgress(vm: vm, isDragging: isDragging) {
                    showAdditionalSettings = true
                }
                .padding(.top)
                .opacity(vm.showPlayerControls ? 1 : 0)
            }
            .padding()
            .padding(.bottom)
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .statusBarHidden(true)
        .blur(radius: showSeriesPicker || showAdditionalSettings ? 20 : 0)
        .allowsHitTesting(!showSeriesPicker && !showAdditionalSettings)
        .overlay(alignment: .bottom) {
            if showSeriesPicker {
                SeriesPicker(list: articlePlayer.list, selected: $vm.selectedVideo, showModal: $showSeriesPicker) {
                    vm.updatePlayer(key: vm.selectedVideo, list: articlePlayer.list)
                }
                .opacity(0.5)
                .allowsHitTesting(true)
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            
            if showAdditionalSettings {
                if let hls = articlePlayer.list[vm.selectedVideo]?.hls {
                    AdditionalSettings(vm: vm,orientation: $orientation, showSettings: $showAdditionalSettings ,hls: hls)
                        .opacity(0.5)
                        .allowsHitTesting(true)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
        .onAppear {
            setupPlayer()
        }
        .onDisappear {
            vm.refreshPlayer()
            
            modifyOrientation(.portrait)
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.35)) {
                vm.showPlayerControls.toggle()
            }
        }
        .preferredColorScheme(.dark)
    }
    
    private func setupPlayer() {
        if !articlePlayer.list.keys.contains(vm.selectedVideo) {
            vm.selectedVideo = String(articlePlayer.episodes.first ?? 1)
        }
        guard let (quality, videoPath) = articlePlayer.list[vm.selectedVideo]?.hls?.getHighestQuality().first,
              let url = URL(string: "https://cache.libria.fun" + videoPath) else {
            vm.player = nil
            return
        }
        
        vm.selectedQuality = quality
        
        vm.player = AVPlayer(url: url)
        
        vm.setupTimeObserver(list: articlePlayer.list)
    }
}

#Preview {
    VideoPlayerView(name: "Может ли существовать дружба между мужчиной и ", articlePlayer: ArticlePlayer(alternativePlayer: nil, host: nil, isRutube: false, episodes: Episodes(first: 1, last: 3, string: "1-3"), list: ["1": ArticleList(episode: 1, name: "Ветреница и принцесса ночи", uuid: "9e9a20fd-be71-45eb-b965-7211386c85d9", createdTimestamp: 1743849239, preview: "/storage/releases/episodes/previews/9904/1/T7fb6pvQcIlXYvVr__5cbee05913de65912748eeedfa49e7f9.jpg", skips: Skips(opening: [5, 30], ending: []), hls: HLS(fhd: "/videos/media/ts/9904/1/1080/87e1456e18bdb004257bf5423d8e7a21.m3u8", hd: "/videos/media/ts/9904/1/720/d41d5d87b56bee0254b556ef07f4f324.m3u8", sd: "/videos/media/ts/9904/1/480/8ced78d8cfab42a7c9077093c4f399c1.m3u8"))], rutube: nil))
}
