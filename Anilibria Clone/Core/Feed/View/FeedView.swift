//
//  FeedView.swift
//  AnilibriaClone
//
//  Created by Мурад on 4/4/25.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var appState: AppState
    @ObservedObject var scheduleToday: ScheduleViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(title: "Лента", trailingImageName: "magnifyingglass", trailingImageAction:  {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        appState.isFocused.toggle()
                    }
                })
                ScrollView {
                    LazyVStack(spacing: 20) {
                        NavigationLink{
                            ScheduleView()
                        } label: {
                            DefaultButton(text: "Расписание") {
                                
                            }
                        }
                        
                        DefaultButton(text: "Случайный релиз") {
                            
                        }
                        
                        DefaultButton(text: "История") {
                            
                        }
                        
                        Text("Обновления")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding(.bottom, -10)
                        
                        ForEach(viewModel.articles) { article in
                            NavigationLink {
                                DetailView(article: article)
                            } label: {
                                ArticleCard(article: article)
                                    .onAppear {
                                        if viewModel.status != .loading && article.id == viewModel.articles.last?.id {
                                            viewModel.fetchArticles()
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                            
                        }
                        if viewModel.status == .loading {
                                ProgressView()
                                .frame(height: 40)
                                .padding(.bottom, 30)
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollIndicators(.hidden)
            }
            .overlay {
                if appState.isFocused {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                    
                    VStack(alignment: .trailing, spacing: 0) {
                        ExpandableTextField(text: $viewModel.searchText, onExit: {
                            withAnimation(.easeInOut(duration: 0.1)) {
                                appState.isFocused = false
                            }
                        }) {
                            viewModel.resultSearch()
                        }
                        
                        if !viewModel.searchResult.isEmpty {
                            ExpandableResultView(searchResult: viewModel.searchResult)
                        }
                        
                    }
                    .onDisappear {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            appState.isFocused = false
                            viewModel.searchResult.removeAll()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                }
            }
            .refreshable(action: {
                viewModel.handleRefresh()
            })
        }
        .onAppear {
            if !appState.isFeedLoaded {
                viewModel.fetchArticles()
                appState.isFeedLoaded = true
            }
        }
    }
}
