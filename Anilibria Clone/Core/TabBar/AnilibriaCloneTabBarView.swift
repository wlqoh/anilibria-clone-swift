//
//  AnilibriaCloneTabBarView.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import SwiftUI

struct AnilibriaCloneTabBarView: View {
    @State var selectedTab: Tabs = .main
    @StateObject var appState = AppState()
    @StateObject var feedViewModel = MainViewModel()
    @StateObject var searchViewModel = MainViewModel()
    @StateObject var youtubeViewModel = YoutubeViewModel()
    @StateObject var scheduleTodayViewModel = ScheduleViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            
            GeometryReader { _ in
                    switch selectedTab {
                    case .main:
                        FeedView(viewModel: feedViewModel, appState: appState, scheduleToday: scheduleTodayViewModel)
                    case .search:
                        SearchView(viewModel: searchViewModel, appState: appState)
                    case .youtube:
                        YoutubeView(viewModel: youtubeViewModel, appState: appState)
                    case .profile:
                        Text("profile")
                }
            }
            .onChange(of: selectedTab) {
                switch selectedTab {
                case .main:
                    if
                    !appState.isFeedLoaded {
                    feedViewModel.fetchArticles()
                    appState.isFeedLoaded = true
                }
                    if !appState.isScheduleTodayLoaded {
                        scheduleTodayViewModel.fetchSchedule(onlyToday: true)
                        appState.isScheduleTodayLoaded = true
                    }
                case .search:if
                    !appState.isSearchLoaded{
                    searchViewModel.fetchArticles()
                    appState.isSearchLoaded = true
                }
                case .youtube:if
                    !appState.isYoutubeLoaded{
                    youtubeViewModel.fetchVideos()
                    appState.isYoutubeLoaded = true
                }
                case .profile:
                    break
                }
            }
            
            HStack {
                
                ForEach(tabItems) { item in
                    Button(action: {
                            selectedTab = item.tab
                    }) {
                        Image(systemName: item.icon)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(selectedTab == item.tab ? Color.theme.primaryTextColor : Color.theme.defaultColor)
                    
                }
            }
            .overlay(alignment: .bottom) {
                if appState.isFocused {
                    Color.black.opacity(0.3)
                        .padding(.bottom, -50)
                        .frame(height: 38)
                }
            }
            .padding(.top, 15)
            .padding(.bottom, 8)
            .background(Color.theme.secondaryBackgroundColor)
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: -1)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct TabItem: Identifiable {
    var id = UUID()
    var icon: String
    var tab: Tabs
}

var tabItems = [
    TabItem(icon: "magazine", tab: .main),
    TabItem(icon: "magnifyingglass", tab: .search),
    TabItem(icon: "play.rectangle", tab: .youtube),
    TabItem(icon: "magazine", tab: .profile),
]

enum Tabs: String {
    case main
    case search
    case youtube
    case profile
}

#Preview {
    AnilibriaCloneTabBarView()
}
