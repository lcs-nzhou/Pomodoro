//
//  PlanningViewModel.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-14.
//

import Foundation

@Observable
class PlanningViewModel: Observable {
    
    //MARK: Stored properties
    
    var availableSubjects: [Tag] = []
    
    //MARK: Initializer
    init() {
        Task{
            try await getSubjects()
        }
    }
    
    //MARK: Functions
    func getSubjects() async throws {
        do {
            let results: [Tag] = try await supabase
                .from("tag")
                .select("id, name")
                .execute()
                .value
            
            dump(results)
            print("Debugging!")
            
            self.availableSubjects = results
            
        } catch {
            debugPrint(error)
        }
    }
    
}
