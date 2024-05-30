//
//  Account.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-30.
//

import SwiftUI

struct Account: View {
    var body: some View {
        VStack {
            Image(systemName:"person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 70)
            
        }
    }
}

#Preview {
    TabView(selection: Binding.constant(4)) {
        LandingView()
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
