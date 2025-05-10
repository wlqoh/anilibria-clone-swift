//
//  SearchCard.swift
//  AnilibriaClone
//
//  Created by Мурад on 11/4/25.
//

import SwiftUI
import Kingfisher

struct SearchCard: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .center) {
            if let image = article.posters?.small?.url {
                ImageLoader(imageUrl: Constants.imageUrl + image)
                    .frame(width: 30, height: 60)
            }
            
            Text(article.names?.ru ?? "")
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.theme.primaryColor)
    }
}

//#Preview {
//    SearchCard(article: Article(id: 9903, code: "slime-taoshite-300-nen-shiranai-uchi-ni-level-max-ni-nattemashita-sono-ni", names: Names(ru: "Убивая слизней 300 лет, неожиданно взяла максимальный уровень 2", en: "Slime Taoshite 300-nen, Shiranai Uchi ni Level Max ni Nattemashita: Sono Ni", alternative: nil), franchises: [Franchises()], announce: nil, status: Status(string: "В работе", code: 1), posters: Posters(small: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil), medium: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil), original: PosterSize(url: "/storage/releases/posters/9903/i0cESJHwsXZYrHvTABCe1o1QCix2gsIh.jpg", rawBase64File: nil)), updated: 1743930116, lastChange: 1743936724, type: ArticleType(fullString: "ТВ (12 эп.), 24 мин.", code: 1, string: "TV", episodes: 12, length: 24), genres: ["Комедия", "Фэнтези"], team: Team(voice: ["Ados", "Amikiri", "WhiteCrow"], translator: [], editing: [], decor: ["Diabl"], timing: ["Shiro"]), season: Season(string: "весна", code: 2, year: 2025, weekDay: 6), description: "Встретились как-то в исекае слегка перекачанная ведьма, две драконихи, два слизёнка, призрак, эльфийка и демоница и... нет, это не анекдот! Это история про перерождённую Адзусу Аидзаву, что абсолютно случайно нафармила себе максимальный уровень и ну уж очень хотела спокойной жизни без приключений.\r\nТолько вышло всё совсем наоборот: что ни день, то новая весёлая история. И неудивительно, ведь с такой компашкой явно не соскучишься! А это значит что? Правильно! Новая порция забавных эпизодов из жизни ведьминой семейки уже здесь.", inFavorites: 1322, blocked: Blocked(copyrights: false, geoip: false, geoipList: nil), player: ArticlePlayer(alternativePlayer: nil, host: nil, isRutube: false, episodes: Episodes(first: 1, last: 1, string: "1-1"), list: nil, rutube: Rutube()), torrents: Torrents(episodes: Episodes(first: 1, last: 1, string: "1-1"), list: nil)))
//}
