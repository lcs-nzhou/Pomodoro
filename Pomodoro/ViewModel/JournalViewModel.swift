//
//  JournalViewModel.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-06.
//

import Foundation

struct Session: Identifiable, Codable {
    var id: Int?
    var date: Date
    var description: String
    var status: Bool
    var startTime: Date
    var endTime: Date
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

struct NewSession: Identifiable, Codable {
    var id: Int?
    var date: Date
    var description: String
    var status: Bool
    var startTime: Date
    var endTime: Date
    var tagId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case description
        case status
        case startTime = "start_time"
        case endTime = "end_time"
        case tagId = "tag_id"
    }
}

@Observable
class JournalViewModel {
    
    // MARK: Stored properties
    // The list of sessions in the past (eventually – right now shows all sessions)
    var sessions: [Session]
    
    init() {
        self.sessions = []
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
            
            self.sessions = results
            
        } catch {
            debugPrint(error)
        }
    }
    
    func filterSessions(on searchTerm: String) async throws {

        if searchTerm.isEmpty {

            // Get all the sessions
            Task {
                try await getSessions()
            }

        } else {

            // Get a filtered list of to-dos
            do {
                let results: [Session] = try await supabase
                    .from("session")
                    .select()
                    .ilike("session", pattern: "%\(searchTerm)%")
                    .order("id", ascending: true)
                    .execute()
                    .value

                self.sessions = results

            } catch {
                debugPrint(error)
            }

        }

    }

    func createSessions(date: Date, description: String, status: Bool, startTime: Date,endTime: Date, tagId: Int) {
        
        // Create a unit of asynchronous work to add the to-do item
        Task {
            
            // Create the new session item instance
            // NOTE: The id will be nil for now
            let session = NewSession(date: date, description: description, status: false, startTime: startTime, endTime: endTime, tagId: tagId)
        
            
            // Write it to the database
            do {
                
                // Insert the new to-do item, and then immediately select
                // it back out of the database
                let newlyInsertedItem: NewSession = try await supabase
                    .from("session")
                    .insert(session)   // Insert the todo item created locally in memory
                    .select()       // Select the item just inserted
                    .single()       // Ensure just one row is returned
                    .execute()      // Run the query
                    .value          // Automatically decode the JSON into an instance of TodoItem
                
                print("WHAT JUST GOT INSERTED?!?!")
                dump(newlyInsertedItem)
                print("=======")

                // Refresh the list of sessions
                try await self.getSessions()
                
            } catch {
                print("Error 😭😭")
                debugPrint(error)
            }
        }
    }
   
}

