//
//  WeekDays.swift
//  AnilibriaClone
//
//  Created by Мурад on 9/4/25.
//

import SwiftUI

struct WeekDays: View {
    let weekDays = ["Пн", "Вт", "Ср", "Чт", "Пт", "Сб", "Вс"]
    let weekDay: Int?
    var body: some View {
        HStack(spacing: 10) {
            ForEach(weekDays.indices, id: \.self) { index in
                ZStack {
                    Circle()
                        .fill(index == weekDay ? Color.red : Color.clear)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: index == weekDay ? 0 : 0.5)
                        )
                    
                    Text(weekDays[index])
                        .foregroundStyle(index == weekDay ? .white : .gray)
                        .font(.caption)
                        .fontWeight(.semibold)
                        
                }
                .frame(width: 33, height: 33)
            }
        }
    }
}

#Preview {
    WeekDays(weekDay: 6)
}
