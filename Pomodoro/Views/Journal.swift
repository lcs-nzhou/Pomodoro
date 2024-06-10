//
//  Journal.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-27.
//

import SwiftUI

struct Journal: View {
    @State private var isSearchVisible = false
    @State private var searchText = ""
    @State private var viewModel = JournalViewModel()
    @State private var date = Date()
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    @State private var selectedTag = ""
    
    struct ColorInfo: Identifiable {
        let id = UUID()
        var name = ""
        var desc = Color.clear
    }
    
    var body: some View {
        
        NavigationStack{
            VStack{
                HStack{
                    NavigationLink{
                        Planning()
                    } label: {
                        Label("", systemImage:"calendar")
                    }
                    
                    Spacer()
                    Text("\(date, formatter: dateFormatter)")
                        .padding()
                       .background(RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color.white))
                    Spacer()
                    if isSearchVisible {
                        TextField("Search...", text: $searchText)
                            .padding()
                    }
                    Button(action: {
                        withAnimation {
                            isSearchVisible.toggle()
                        }
                    }) {
                        Image(systemName: "magnifyingglass")
                    }

                }
                .padding()
                VStack{
                    Text("Next study time scheduled")
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.blue)
                            .opacity(0.1)
                        ) }
                .padding()
                
                
                List(viewModel.sessions) { session in
                    VStack(alignment: .leading){
                        Text(session.description)
                        HStack{
                            Text(session.date)
                                .foregroundStyle(.gray)
                            Text("Tag")
                                .foregroundStyle(.gray)
                        }
                       
                    }
                    
                }
                Spacer()
            }
            
        }
        
    }
}

#Preview {
    TabView(selection: Binding.constant(2)) {
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

