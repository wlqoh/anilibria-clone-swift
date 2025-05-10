//
//  ScheduleService.swift
//  AnilibriaClone
//
//  Created by Мурад on 7/4/25.
//

import Foundation

class ScheduleService: BaseService {
    
    func fetchSchedule(onlyToday isToday: Bool, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        let url = "title/schedule?days=\(isToday ? "\(Date().weekDay - 1)" : "")"
        fetchData(url, responseType: [Schedule].self, completion: completion)
    }
}
