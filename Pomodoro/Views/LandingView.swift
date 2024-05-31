//
//  ContentView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-24.
//

import SwiftUI

struct LandingView: View {
    
    @State var newDescription = ""
    @State private var timerIsRunning = false
    @State private var time = 0
   
    
    var body: some View {
        VStack {
            HStack {
                Picker("Name", selection: $time) {
                    Text("60:00").tag(60)
                    Text("45:00").tag(45)
                    Text("30:00").tag(30)
                    Text("15:00").tag(15)
                }
                .pickerStyle(.wheel)
                Text("Minutes")
            }
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

