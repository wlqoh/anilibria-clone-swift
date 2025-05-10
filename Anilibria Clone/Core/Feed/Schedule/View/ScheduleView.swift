//
//  ScheduleView.swift
//  AnilibriaClone
//
//  Created by Мурад on 16/4/25.
//

import SwiftUI
import Kingfisher

struct ScheduleView: View {
    @StateObject private var viewModel = ScheduleViewModel()
    let weekDays = ["Понедельник", "Вторник", "Среда", "Четверг", "Пятница", "Суббота", "Воскресенье"]
    var columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, alignment: .leading, spacing: 16) {
                ForEach(viewModel.schedule.indices, id: \.self) { index in
                    Section(header: Text(weekDays[index]).font(.subheadline).fontWeight(.bold)) {
                        ForEach(viewModel.schedule[index].list) { article in
                            if let imageUrl = article.posters?.medium?.url {
                                NavigationLink {
                                    DetailView(article: article)
                                } label: {
                                    ImageLoader(imageUrl: Constants.imageUrl + imageUrl)
                                        .mask(RoundedRectangle(cornerRadius: 5))
                                }
                                
                            }
                        }
                    }
                }
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(Color.theme.secondaryBackgroundColor, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Расписание")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchSchedule(onlyToday: false)
        }
    }
}
