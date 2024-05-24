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
        GridItem(.adaptive(minimum: 100, maximum: 200), alignment: .top),
        GridItem(.adaptive(minimum: 100, maximum: 200), alignment: .top),
    ]
        
    // MARK: Computed properties
    var body: some View {
        
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: twoColumns) {
                /*    ForEach(allLandmarks) { currentLandmark in
                                   
                        NavigationLink {
                            DetailView(item: currentLandmark)
                        } label: {
                            GalleryItemView(item: currentLandmark)
                        }
                        .tint(.primary)*/
                    }
                    .navigationTitle("Achievements")
                }
            }
           
                        
        }
    }


#Preview {
    TabView(selection: Binding.constant(3)) {
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
        Achievement()
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
