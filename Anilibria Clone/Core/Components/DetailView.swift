//
//  DetailView.swift
//  AnilibriaClone
//
//  Created by Мурад on 9/4/25.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    let article: Article
    @Environment(\.dismiss) var dismiss
    let defaultHeight = .screenHeight * 0.6
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .top) {
                if let image = article.posters?.original?.url {
                    let url = "\(Constants.imageUrl)\(image)"
                    backgroundImage(url).onTapGesture {
                        isPresented = true
                    }
                    
                }
                VStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(article.names?.ru ?? "")
                                .font(.headline)
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            InFavourites(count: article.inFavorites ?? 0)
                        }
                        Group {
                            Text(article.names?.en ?? "")
                                .font(.callout)
                                .fontWeight(.bold)
                                .foregroundStyle(.secondary)
                                .padding(.bottom)
                            
                            Text("Тип: ")
                                .fontWeight(.bold) +
                            Text(article.type?.fullString ?? "")
                            
                            Text("Год: ")
                                .fontWeight(.bold) +
                            Text(String(article.season?.year ?? 0))
                            
                            Text("Голоса:") + Text(article.team?.voice?.joined(separator: ",") ?? "")
                                .fontWeight(.bold)
                            
                            Text("Состояние релиза: ")
                                .fontWeight(.bold) +
                            Text(article.status?.string ?? "")
                            
                            Text("Жанр:") + Text(article.genres?.joined(separator: ",") ?? "")
                                .foregroundStyle(.red)
                                .fontWeight(.bold)
                        }
                        .font(.callout)
                        
                        Group {
                            Divider()
                                .padding(.top)
                            
                            HStack {
                                Spacer()
                                
                                WeekDays(weekDay: article.season?.weekDay)
                                
                                Spacer()
                            }
                            
                            Divider()
                            
                            Text(article.description ?? "")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
                .background(Color.theme.backgroundColor)
                .padding(.top, .screenHeight * 0.35)
                .frame(maxWidth: .infinity)
                .navigationBarBackButtonHidden(true)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarTitleDisplayMode(.inline)
                .toolbarBackground(Color.theme.secondaryBackgroundColor, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Описание")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .frame(width: 24, height: 24)
                                .foregroundStyle(Color.theme.defaultColor)
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                VideoPlayerView(name: article.names?.ru ?? "", articlePlayer: article.player)
            }
        }
        .scrollIndicators(.hidden)
    }
    
    @ViewBuilder
    private func backgroundImage(_ url: String) -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .scrollView(axis: .vertical)).minY - 16
            let progress = max(defaultHeight, defaultHeight / 3 - (-minY))
            let imagePadding = abs(min(minY / 1.4, 300))
            
            KFImage(URL(string:  url))
                .resizable()
                .scaledToFill()
                .overlay(alignment: .center) {
                    Image(systemName: "play.fill")
                        .font(.title2)
                        .fontWeight(.ultraLight)
                        .foregroundStyle(.white)
                        .padding(15)
                        .background {
                            Circle()
                                .fill(.red)
                        }
                }
                .padding(.bottom, imagePadding)
                .padding(.bottom, .screenHeight * 0.3)
                .frame(height: progress)
                .offset(y: minY < 0 ? -minY : 0)
                
            
        }
        .frame(height: defaultHeight)
    }
    
}


//#Preview {
//    DetailView(article: Article(id: 9903, code: "slime-taoshite-300-nen-shiranai-uchi-ni-level-max-ni-nattemashita-sono-ni", names: Names(ru: "Убивая слизней 300 лет, неожиданно взяла максимальный уровень 2", en: "Slime Taoshite 300-nen, Shiranai Uchi ni Level Max ni Nattemashita: Sono Ni", alternative: nil), franchises: [Franchises()], announce: nil, status: Status(string: "В работе", code: 1), posters: Posters(small: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil), medium: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil), original: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil)), updated: 1743930116, lastChange: 1743936724, type: ArticleType(fullString: "ТВ (12 эп.), 24 мин.", code: 1, string: "TV", episodes: 12, length: 24), genres: ["Комедия", "Фэнтези"], team: Team(voice: ["Ados", "Amikiri", "WhiteCrow"], translator: [], editing: [], decor: ["Diabl"], timing: ["Shiro"]), season: Season(string: "весна", code: 2, year: 2025, weekDay: 6), description: "Встретились как-то в исекае слегка перекачанная ведьма, две драконихи, два слизёнка, призрак, эльфийка и демоница и... нет, это не анекдот! Это история про перерождённую Адзусу Аидзаву, что абсолютно случайно нафармила себе максимальный уровень и ну уж очень хотела спокойной жизни без приключений.\r\nТолько вышло всё совсем наоборот: что ни день, то новая весёлая история. И неудивительно, ведь с такой компашкой явно не соскучишься! А это значит что? Правильно! Новая порция забавных эпизодов из жизни ведьминой семейки уже здесь.", inFavorites: 1322, blocked: Blocked(copyrights: false, geoip: false, geoipList: nil), player: ArticlePlayer(alternativePlayer: nil, host: nil, isRutube: false, episodes: Episodes(first: 1, last: 1, string: "1-1"), list: nil, rutube: Rutube()), torrents: Torrents(episodes: Episodes(first: 1, last: 1, string: "1-1"), list: nil)))
//}
