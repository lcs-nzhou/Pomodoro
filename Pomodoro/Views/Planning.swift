//
//  Planning.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-30.
//

import SwiftUI

struct Planning: View {
    //MARK: Computed properties
    @State private var selectedDate = Date()
    @State private var fromTime = Date()
    @State private var forHowLong = Int()
    @State private var selectedTag = 1
    @State private var description = ""
    @State private var showTagSelection = false
    
    // Binding to control whether this view is visible
    @Binding var showSheet: Bool
    
    // Have access to the JournalViewModel
    @Environment(JournalViewModel.self) var viewModel
    
    @State private var planningViewModel = PlanningViewModel()
    
    //bind two date pickers
    private func setDateComponents(_ time: Date, with date: Date) -> Date {
           var calendar = Calendar.current
           calendar.timeZone = TimeZone.current
           
           let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
           var dateComponents = calendar.dateComponents([.year, .month, .day], from: date)
           dateComponents.hour = timeComponents.hour
           dateComponents.minute = timeComponents.minute
           
           return calendar.date(from: dateComponents) ?? Date()
       }
    
    //MARK: Computed properties
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    displayedComponents: .date
                )
                .datePickerStyle(GraphicalDatePickerStyle())
                .accentColor(.blue)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.blue.opacity(0.1))
                        .shadow(radius: 1, x: 4, y: 4)
                )
                .padding(.horizontal)
                
                Form {
                    
                    DatePicker("From Time", selection: $fromTime, displayedComponents: .hourAndMinute)
                        .onChange(of: selectedDate) {
                            fromTime = setDateComponents(fromTime, with: selectedDate)
                        }
                    Text("For 45 minutes")
                    
                    Picker("Tag", selection: $selectedTag) {
                        ForEach(planningViewModel.availableSubjects) {
                            subject in
                            Text(subject.name).tag(subject.id!)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    TextField("Description", text: $description)
                }
                Button("Submit"){
                    viewModel.createSessions(date: selectedDate, description: description, startTime: fromTime, tagId: selectedTag, duration: 45)
                    description = ""
                    selectedTag = 1
                    fromTime = Date()
                    selectedDate = Date()
                    
                }
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)

            }
            .padding()
            
            Spacer()
        }
    }

   
}



#Preview {
    Planning(showSheet: .constant(true) )
        .environment(JournalViewModel())
}
