//
//  Journal.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-27.
//

import SwiftUI

struct Journal: View {
    //MARK: Stored properties
    @State private var isSearchVisible = false
    @State private var searchText = ""
    @State private var viewModel = JournalViewModel()
    @State private var date = Date()
    
    //Is the sheet to add a new item showing right now?
    @State var presentingNewItemSheet = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    //MARK: Computed properties
    var body: some View {
        
        var nearestFutureSession: Session? {
                viewModel.sessions
                    .filter { $0.date > Date() }
                    .sorted { $0.date < $1.date }
                    .first
            }
        
        NavigationStack{
            VStack{
                HStack{
                    Button {
                        presentingNewItemSheet = true
                    } label: {
                        Image(systemName: "calendar")
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
               
                if let session = nearestFutureSession {
                    VStack(alignment: .leading) {
                        Text("Next Session:")
                            .font(.headline)
                        Text(session.description)
                        HStack {
                            Text("\(session.startTime.formatted(date: .abbreviated, time: .shortened))")
                                .foregroundColor(.gray)
                            Text(session.tag.name)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.1)))
                    .padding()
                } else {
                    Text("No upcoming sessions")
                        .foregroundColor(.gray)
                        .padding()
                }
                
                HStack {
                    Text("Past Sessions")
                        .bold()
                        .font(.title)
                        .padding(.leading)
                    Spacer()
                }
                
                List(viewModel.sessions.filter{$0.date <= Date() }) { session in
                    VStack(alignment: .leading){
                        Text(session.description)
                        HStack{
                            Text("\(session.startTime.formatted(date: .abbreviated, time: .shortened))")
                                .foregroundStyle(.gray)
                            Text(session.tag.name)
                                .foregroundStyle(.gray)
                        }
                       
                    }
                    
                }
                .listStyle(.plain)
                Spacer()
            }
            //Show the sheet to add a new item
            .sheet(isPresented: $presentingNewItemSheet) {
                Planning(showSheet: $presentingNewItemSheet)
            }
        }
        .environment(JournalViewModel())
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

