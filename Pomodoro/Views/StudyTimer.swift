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
    
    // Represents the different states the timer can be in
    enum TimerState {
        case active
        case paused
        case resumed
        case cancelled
    }
    
    
    // MARK: Private Properties
    private var timer = Timer()
    private var totalTimeForCurrentSelection: Int {
        (selectedHoursAmount * 3600) + (selectedMinutesAmount * 60)
    }
    
    // MARK: Public Properties
    @Published var state: TimerState = .cancelled {
        didSet {
            // Modeled as a state machine for easier testing and
            // a cleaner / more readable implementation
            switch state {
            case .cancelled:
                // Cancel the timer and reset all progress properties
                timer.invalidate()
                secondsToCompletion = 0
                progress = 0
                
            case .active:
                // Starts the timer and sets all progress properties
                // to their initial values
                startTimer()
                
                secondsToCompletion = totalTimeForCurrentSelection
                progress = 1.0
                
                updateCompletionDate()
                
            case .paused:
                // We want to pause the timer, but we
                // don't want to change the state of our progress
                // properties (secondsToCompletion and progress)
                timer.invalidate()
                
            case .resumed:
                // Resumes the timer
                startTimer()
                
                // We don't know how long we've been paused for, so
                // we need to update our ETA
                updateCompletionDate()
            }
        }
    }
    
    // Powers the ProgressView
    @Published var secondsToCompletion = 0
    @Published var progress: Float = 0.0
    @Published var completionDate = Date.now
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] _ in
            guard let self else { return }
            
            self.secondsToCompletion -= 1
            self.progress = Float(self.secondsToCompletion) / Float(self.totalTimeForCurrentSelection)
            
            // We can't do <= here because we need to ensure the animation
            // has time to finish running (see .linear(duration: 1.0))
            if self.secondsToCompletion < 0 {
                self.state = .cancelled
            }
        })
    }
    
    private func updateCompletionDate() {
        completionDate = Date.now.addingTimeInterval(Double(secondsToCompletion))
    }
}

extension Int {
    var asTimestamp: String {
        let hour = self / 3600
        let minute = self / 60 % 60
        let second = self % 60
        
        return String(format: "%02i:%02i:%02i", hour, minute, second)
    }
}

struct StartButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 200, height: 200)
            .foregroundColor(.blue)
            .background(.blue.opacity(0.3))
            .clipShape(Circle())
            .padding(.all, 3)
            .font(.title)
            .bold()
            .overlay(
                Circle()
                    .stroke(.blue
                        .opacity(0.3), lineWidth: 2)
            )
    }
}

struct CancelButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            .background(.blue, in: Capsule())
            .foregroundColor(.white)
            .cornerRadius(5)
            .padding(.top)
    }
}

struct PauseButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
            .background(.cyan.opacity(0.3), in: Capsule())
            .foregroundColor(.cyan)
            .cornerRadius(5)
            .padding(.top)
    }
}


struct StudyTimer: View {
    
    @State var newDescription = ""
    @State private var timerIsRunning = false
    @State private var time = 0
    @State private var favoriteState = 1
    @State private var selectedTag = ""
    @State private var showTagSelection = false
    
    @StateObject private var model = TimerViewModel()
    
    var timerControls: some View {
        VStack {
            switch model.state {
            case .cancelled:
                Button("Start") {
                    model.state = .active
                }
                .buttonStyle(StartButtonStyle())
            case .paused:
                Button("Resume") {
                    model.state = .resumed
                }
                .buttonStyle(PauseButtonStyle())
            case .active, .resumed:
                Button("Pause") {
                    model.state = .paused
                }
               .buttonStyle(PauseButtonStyle())
            }
                
            
            Button("Cancel") {
                model.state = .cancelled
            }
            .buttonStyle(CancelButtonStyle())
            
        }
        .padding(.all, 32)
    }
    
    var timePickerControl: some View {
        HStack() {
            TimePickerView(title: "hours",
                           range: model.hoursRange,
                           binding: $model.selectedHoursAmount)
            TimePickerView(title: "min",
                           range: model.minutesRange,
                           binding: $model.selectedMinutesAmount)
        }
        .frame(width: 360, height: 255)
        //.padding(.all, 32)
    }
    
    var progressView: some View {
        ZStack {
            withAnimation {
                CircularProgressView(progress: $model.progress)
            }
            
            VStack {
                Text(model.secondsToCompletion.asTimestamp)
                    .font(.largeTitle)
                HStack {
                    Image(systemName: "bell.fill")
                    Text(model.completionDate, format: .dateTime.hour().minute())
                }
            }
        }
        .frame(width: 360, height: 255)
        .padding(.all, 32)
    }
    
    var body: some View {
        
        ScrollView {
            VStack {
                if model.state == .cancelled {
                    timePickerControl
                } else {
                    progressView
                }
                
                timerControls
                
                HStack {
                    HStack {
                        Text("Tag")
                        Spacer()
                        Text(selectedTag.isEmpty ? "Select Tag" : selectedTag)
                            .foregroundColor(.gray)
                            .onTapGesture {
                                showTagSelection = true
                            }
                            .sheet(isPresented: $showTagSelection) {
                                TagSelectionView(selectedTag: $selectedTag)
                            }
                    }
                    .contentShape(Rectangle())
                    .padding(.trailing)
                   
                    
                    Spacer()
                }
                .padding(.leading)
                
                HStack {
                    Text("Description:")
                    TextField("Enter description", text: $newDescription)
                    Spacer()
                }
                .padding(.leading)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        
        
        
    }
    
}




#Preview {
    TabView(selection: Binding.constant(1)) {
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

