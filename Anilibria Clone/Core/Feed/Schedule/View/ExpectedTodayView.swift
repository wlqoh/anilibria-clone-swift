//
//  ExpectedTodayView.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import SwiftUI
import Kingfisher

struct ExpectedTodayView: View {
    @ObservedObject var viewModel: ScheduleViewModel
    
    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack {
                if let list = viewModel.schedule.first?.list {
                    ForEach(list) { schedule in
                        NavigationLink {
                            DetailView(article: schedule)
                        } label: {
                            if let imageUrl = schedule.posters?.original?.url {
                                ImageLoader(imageUrl: Constants.imageUrl + imageUrl)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                            }
                        }
                    }
                }
                
            }
            .overlay {
                if let error = viewModel.errorMessage {
                    Text(error).font(.subheadline)
                }
            }
        }
        .scrollIndicators(.hidden)
        .frame(height: 200)
    }
}
