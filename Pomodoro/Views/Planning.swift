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
    @State private var tag = ""
    @State private var description = ""
   
    var body: some View {
        
        VStack(spacing: 30) {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                    .opacity(0.1)
                    .shadow(radius: 1, x: 4, y: 4))
                .padding(.horizontal)
            Form {
                DatePicker("From time", selection: $fromTime,
                           displayedComponents: .hourAndMinute)
                DatePicker("To time", selection: $toTime,
                           displayedComponents: .hourAndMinute)
                Text("Tag")
                HStack {
                    Text("Description")
                    TextField("", text: $description)
                }
            }
            Button(action: submit) {
                Text("Submit")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        
        
        Spacer()
        
    }
    
    func submit() {
        // Print the selected values to the console
        print("Selected Date: \(selectedDate)")
        print("From Time: \(fromTime)")
        print("To time: \(toTime)")
        print("Tag: \(tag)")
        print("Description: \(description)")
        
        //Optionally reset the form after submission
        selectedDate = Date()
        fromTime = Date()
        toTime = Date()
        tag = ""
        description = ""
    }
}



#Preview {
    Planning()
}
