//
//  ContentView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

struct LandingView: View {
    
    @State var newDescription = ""
    @State var date = Date()
    @State private var timeRemaining = 60
    @State private var timerIsRunning = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            DatePicker("", selection: $date)
                .datePickerStyle(.wheel)
                .labelsHidden()
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .frame(maxWidth: 350)
                if !timerIsRunning {
                    Button(action: startTimer) {
                        Text("Start Timer")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    Button(action: stopTimer) {
                        Text("Stop Timer")
                            .font(.title)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            HStack {
                Text("Tag:")
                Spacer()
            }
            HStack {
                Text("Description:")
                TextField("Enter description", text: $newDescription)
                Spacer()
            }
            Spacer()
        }
        .padding()
    }
}

func startTimer() {
    
}

func stopTimer() {
    
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

