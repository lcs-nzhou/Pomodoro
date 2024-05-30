//
//  Journal.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-27.
//

import SwiftUI

struct Journal: View {
    
    struct ColorInfo: Identifiable {
        let id = UUID()
        var name = ""
        var desc = Color.clear
    }
    
    var body: some View {
        @State var colors = [
            ColorInfo(name: "Red", desc: Color.red),
            ColorInfo(name: "Blue", desc: Color.blue),
            ColorInfo(name: "Purple", desc: Color.purple)
        ]
        VStack{
            HStack{
                Image(systemName: "calendar")
                Spacer()
                Text("May")
                Spacer()
                Image(systemName: "magnifyingglass")
            }
            .padding()
            VStack{
                HStack{
                    Text("May 30 Thu")
                        .padding(.leading)
                    Spacer()
                }
                Table(colors) {
                    TableColumn("Names") { color in
                        Text(color.name)
                    }
                    TableColumn("Colors") { color in
                        color.desc
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    TabView(selection: Binding.constant(2)) {
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
        Text("Account")
            .tabItem {
                Image(systemName: "person.fill")
            }
            .tag(4)
    }
}

