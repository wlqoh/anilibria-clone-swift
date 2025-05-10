//
//  AppState.swift
//  AnilibriaClone
//
//  Created by Мурад on 13/4/25.
//

import Foundation

final class AppState: ObservableObject {
    @Published var isFocused = false
    @Published var isFeedLoaded = false
    @Published var isSearchLoaded = false
    @Published var isYoutubeLoaded = false
    @Published var isScheduleTodayLoaded = false
}
