//
//  VideoPlayerViewModel.swift
//  AnilibriaClone
//
//  Created by Мурад on 19/4/25.
//
import Combine
import SwiftUI
import AVKit

class VideoPlayerViewModel: ObservableObject {
    @Published var player: AVPlayer?
    
    @Published var showPlayerControls: Bool = true
    @Published var isPlaying: Bool = false
    @Published var isFinishedPlaying: Bool = false
    @Published var isSeeking: Bool = false
    @Published var progress: CGFloat = 0
    @Published var selectedVideo: String = "1"
    @Published var isAllowedToSkip: Bool = false
    @Published var selectedQuality: VideoQuality?
    
    private var observer: NSKeyValueObservation?
    
    func updatePlayer(key: String, list: [String: ArticleList]) {
        refreshPlayer()
        selectedVideo = key
        
        if let bundle = URL(string: "https://cache.libria.fun" + (list[selectedVideo]?.hls?.getHighestQuality().first?.value ?? "" )) {
            player?.replaceCurrentItem(with: AVPlayerItem(url: bundle))
        }
    }
    
    func changeQuality(hls: HLS) {
        guard let player, let quality = selectedQuality,
              let bundle = URL(string: "https://cache.libria.fun" + (hls.avialableQuality()[quality]!)) else { return }
        
        player.pause()
        isPlaying = false
        
        let seconds = player.currentTime().seconds
        
        let newItem = AVPlayerItem(url: bundle)
        player.replaceCurrentItem(with: newItem)
        
        observer = newItem.observe(\.status, options: [.new, .initial]) { [weak self] item, _ in
            guard let self = self else { return }
            if item.status == .readyToPlay {
                item.seek(to: CMTime(seconds: seconds, preferredTimescale: 600), toleranceBefore: .zero, toleranceAfter: .positiveInfinity) { _ in
                    self.observer?.invalidate()
                    self.observer = nil
                }
            }
        }
    }
    
    func seekTo(_ sec: Double, isForward: Bool) {
        if let player = player {
            let seconds = isForward ? player.currentTime().seconds + sec : player.currentTime().seconds - sec
            player.seek(to: .init(seconds: seconds, preferredTimescale: 1), toleranceBefore: .zero, toleranceAfter: .positiveInfinity)
        }
    }
    
    func setupTimeObserver(list: [String: ArticleList]) {
        player?.addPeriodicTimeObserver(forInterval: .init(seconds: 1, preferredTimescale: 1), queue: .main, using: { time in
            if let currentPlayerItem = self.player?.currentItem {
                let totalDuration = currentPlayerItem.duration.seconds
                let currentTime = self.player?.currentTime() ?? .zero
                guard currentTime.isValid && !currentTime.seconds.isNaN else { return }
                let currentDuration = currentTime.seconds
                guard let skips = list[self.selectedVideo]?.skips else { return }
                if skips.opening.count == 2 {
                    if Int(currentDuration) >= skips.opening.first! && Int(currentDuration) <= skips.opening.first! + 10 {
                        withAnimation {
                            self.isAllowedToSkip = true
                        }
                    }
                    else {
                        withAnimation {
                            self.isAllowedToSkip = false
                        }
                    }
                }
                
                let calculatedProgress = currentDuration / totalDuration
                
                if !self.isSeeking {
                    self.progress = calculatedProgress
                }
                
                if calculatedProgress == 1 {
                    self.isFinishedPlaying = true
                }
            }
        })
    }
    
    func refreshPlayer() {
        player?.pause()
        player?.seek(to: .zero)
        progress = .zero
        isFinishedPlaying = false
        isPlaying = false
    }
}

enum VideoQuality: String, CaseIterable {
    case fhd = "1080p"
    case hd = "720p"
    case sd = "480p"
    
    func isAvailable(in hls: HLS) -> Bool {
        switch self {
        case .fhd:
            return hls.fhd != nil
        case .hd:
            return hls.hd != nil
        case .sd:
            return true
        }
    }
}
