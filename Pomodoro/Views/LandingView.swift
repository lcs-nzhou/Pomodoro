//
//  LandingView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-03.
//

import SwiftUI

struct LandingView: View {
    @State private var titleoffset = -350
    var body: some View {
    
        NavigationStack {
            VStack{
                Text("Pomodoro")
                    .font(.largeTitle)
                    .bold()
                
                Image("Pomodoro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                NavigationLink{
                    StudyTimer()
                } label: {
                    Label("Get Started", systemImage:"")
                }
            }
        }
    }
}

#Preview {
    LandingView()
}
