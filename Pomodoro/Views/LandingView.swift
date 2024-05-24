//
//  ContentView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

struct LandingView: View {
    
    @State var newTag = ""
    @State var date = Date()
    
    var body: some View {
        VStack {
            DatePicker("", selection: $date)
                .datePickerStyle(.wheel)
            Circle()
                .foregroundColor(.blue)
                .frame(maxWidth: 350)
            HStack {
                Text("Tag:")
                Spacer()
            }
            HStack {
                Text("Description:")
                Spacer()
            }
            TextField("Add tag", text: $newTag)
            Spacer()
        }
        .padding()
        .ignoresSafeArea()
    }
}

#Preview {
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

