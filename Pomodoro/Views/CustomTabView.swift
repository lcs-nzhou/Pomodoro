//
//  CustomTabView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-03.
//

import SwiftUI

struct CustomTabView: View {
    var body: some View {
        TabView(selection: Binding.constant(1)) {
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
}

#Preview {
    CustomTabView()
}
