//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

@main
struct PomodoroApp: App {
    var body: some Scene {
        WindowGroup {
            TabView(selection: Binding.constant(1)) {
                LandingView()
                    .tabItem{
                        Image(systemName: "alarm.fill")
                    }
                    .tag(1)
                Text("Journal")
                    .tabItem {
                        Image(systemName: "book")
                    }
                    .tag(2)
                Text("achievement")
                    .tabItem {
                        Image(systemName: "medal.fill")
                        
                    }
                    .tag(3)
                Text("Account")
                    .tabItem {
                        Image(systemName: "person.fill")
                    }
                    .tag(4)
            }
        }
    }
}
