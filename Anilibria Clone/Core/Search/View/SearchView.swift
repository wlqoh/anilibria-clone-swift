//
//  SearchView.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: MainViewModel
    @ObservedObject var appState: AppState
    
    var body: some View {
        NavigationStack {
            VStack {
                HeaderView(title: "Поиск", trailingImageName: "magnifyingglass", trailingImageAction: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        appState.isFocused.toggle()
                    }
                })
                ScrollView {
                    LazyVStack(spacing: 20) {
                        ForEach(viewModel.articles) { article in
                            NavigationLink {
                                DetailView(article: article)
                            } label: {
                                ArticleCard(article: article)
                                    .onAppear {
                                        if article.id == viewModel.articles.last?.id {
                                            viewModel.fetchArticles()
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                        
                        if viewModel.status == .loading {
                            ProgressView()
                                .padding(.bottom)
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
                    
                    VStack(spacing: 0) {
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
    }
}


