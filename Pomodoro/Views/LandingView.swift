//
//  LandingView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-03.
//

import SwiftUI

struct LandingView: View {
    
    @State private var titleOffset = -350.0
    
    var body: some View {
    
        NavigationStack {
            VStack{
                Text("Pomodoro")
                    .font(.largeTitle)
                    .bold()
                    .offset(x: titleOffset)
                
                Image("Pomodoro")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                NavigationLink{
                    CustomTabView()
                } label: {
                    Label("Get Started", systemImage:"")
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
    LandingView()
}
