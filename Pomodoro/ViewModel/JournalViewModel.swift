//
//  JournalViewModel.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-06.
//

import Foundation

struct Session: Identifiable, Codable {
    var id: Int?
    var date: String
    var description: String
    var status: Bool
    var startTime: String
    var endTime: String
    var tag: Tag
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case status
        case startTime = "start_time"
        case endTime = "end_time"
        case tag
    }
    
    struct Tag: Identifiable, Codable {
        var id: Int?
        var name: String
    }
}



@Observable
class JournalViewModel {
    
    
    init() {
        Task {
            try await getSessions()
        }
    }
    
    func getSessions() async throws {
        do {
            let results: [Session] = try await supabase
                .from("session")
                .select("id, date, description, status, start_time, end_time, tag(id, name)")
                .execute()
                .value
            
            dump(results)
            print("Debugging!")
        } catch {
            debugPrint(error)
        }
    }
    
   
}
