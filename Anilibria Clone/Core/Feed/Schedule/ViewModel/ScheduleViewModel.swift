//
//  ScheduleViewModel.swift
//  AnilibriaClone
//
//  Created by Мурад on 16/4/25.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var schedule = [Schedule]()
    @Published var errorMessage: String?
    @Published var status: StandardListStatus = .loading
    
    private let service = ScheduleService()
    
    func fetchSchedule(onlyToday: Bool) {
        service.fetchSchedule(onlyToday: onlyToday) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let schedule):
                    self.schedule = schedule
                    self.status = .loaded
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.status = .error
                }
            }
            
        }
    }
}
