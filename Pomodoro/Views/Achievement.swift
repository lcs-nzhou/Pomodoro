//
//  Achievement.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

struct Achievement: View {
    
    // MARK: Stored properties
    let twoColumns = [
        GridItem(),
        GridItem(),
    ]
        
    // MARK: Computed properties
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: twoColumns) {
                    ForEach(1..<11) { item in
                        NavigationLink(destination: MedalDetailView()){
                            Image("NewMedal")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                        }
                        
                    }
                }
                .navigationTitle("Achievements")
            }
        }
        
        
    }
}


#Preview {
    TabView(selection: Binding.constant(3)) {
        StudyTimer()
            .tabItem{
                Image(systemName: "alarm.fill")
            }
            .tag(1)
        Journal()
            .tabItem {
                Image(systemName: "book")
            }
            .tag(2)
        Achievement()
            .tabItem {
                Image(systemName: "medal.fill")
                
            }
            .tag(3)
        Account()
            .tabItem {
                Image(systemName: "person.fill")
            }
            .tag(4)
    }
}
