//
//  Planning.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-30.
//

import SwiftUI

struct Planning: View {
    @State private var selectedDate = Date()
    @State private var fromTime = Date()
    @State private var toTime = Date()
    @State private var selectedTag = ""
    @State private var description = ""
    @State private var showTagSelection = false
    @Environment(JournalViewModel.self) var viewModel
    
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
                    DatePicker("To Time", selection: $toTime, displayedComponents: .hourAndMinute)
                    
                    HStack {
                        Text("Tag")
                        Spacer()
                        Text(selectedTag.isEmpty ? "Select Tag" : selectedTag)
                            .foregroundColor(.gray)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        showTagSelection = true
                    }
                    .sheet(isPresented: $showTagSelection) {
                        TagSelectionView(selectedTag: $selectedTag)
                    }
                    
                    TextField("Description", text: $description)
                }
                Button("Submit"){
                    viewModel.createSessions(date: selectedDate, description: description, status: false, startTime: fromTime, endTime: toTime, TagId: 1)
                }
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
//                Button(action: submit) {
//                    Text("Submit")
//                        .font(.title)
//                        .padding()
//                        .background(Color.blue)
//                        .foregroundColor(.white)
//                        .cornerRadius(10)
//                }
            }
            .padding()
            
            Spacer()
        }
    }
//    HStack {
//        TextField("Enter a to-do item", text: $newItemDescription)
//        
//        Button("ADD") {
//            // Add the new to-do item
//            viewModel.createToDo(withTitle: newItemDescription)
//            // Clear the input field
//            newItemDescription = ""
//        }
//        .font(.caption)
//        .disabled(newItemDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == true)
//    }
    func submit() {
        // Print the selected values to the console
        print("Selected Date: \(selectedDate)")
        print("From Time: \(fromTime)")
        print("To Time: \(toTime)")
        print("Tag: \(selectedTag)")
        print("Description: \(description)")
        
        // Optionally reset the form after submission
        selectedDate = Date()
        fromTime = Date()
        toTime = Date()
        selectedTag = ""
        description = ""
    }
}



#Preview {
    Planning()
        .environment(JournalViewModel())
}
