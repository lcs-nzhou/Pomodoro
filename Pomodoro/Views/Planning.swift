//
//  Planning.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-30.
//

import SwiftUI

struct Planning: View {
    @State var date = Date()
   
    var body: some View {
        
        VStack(spacing: 30) {
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .accentColor(.blue)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20)
                    .fill(Color.blue)
                    .opacity(0.1)
                    .shadow(radius: 1, x: 4, y: 4))
                .padding(.horizontal)
            Form {
                DatePicker("From time", selection: $date,
                           displayedComponents: .hourAndMinute)
                DatePicker("To time", selection: $date,
                           displayedComponents: .hourAndMinute)
                Text("Tag")
                Text("Description")
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
}

func submit() {
    
}

#Preview {
    Planning()
}
