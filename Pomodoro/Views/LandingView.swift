//
//  ContentView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var selectedHoursAmount = 0
    @Published var selectedMinutesAmount = 45

    let hoursRange = 0...10
    let minutesRange = 0...59
   
}

struct LandingView: View {
    
    @State var newDescription = ""
    @State private var timerIsRunning = false
    @State private var time = 0
   
    @StateObject private var model = TimerViewModel()
    var body: some View {
        
        VStack {
            HStack() {
                TimePickerView(title: "hours",
                               range: model.hoursRange,
                               binding: $model.selectedHoursAmount)
                TimePickerView(title: "min",
                               range: model.minutesRange,
                               binding: $model.selectedMinutesAmount)
               
            }
            .padding(.all, 32)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          
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

