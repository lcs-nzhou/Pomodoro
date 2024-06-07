//
//  LandingView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-03.
//

import SwiftUI

struct LandingView: View {
    
    @State private var titleOffset = -350.0
    @Binding var getStarted: Bool
    
    var body: some View {
    
        NavigationStack {
            VStack{
                Text("PomodoroPro")
                    .font(.largeTitle)
                    .bold()
                    .offset(x: titleOffset)
                
                Image("Pomodoro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: 300)
                
                Text("Get Started")
                    .bold()
                    .font(.title)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        getStarted = true
                    }
            }
        }
        .task {
            withAnimation(.bouncy()) {
                titleOffset = 0.0
            }
            
        }
    }
}

#Preview {
    LandingView(getStarted: .constant(false))
}
