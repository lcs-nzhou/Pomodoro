//
//  OpeningView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-07.
//

import SwiftUI

struct OpeningView: View {
    
    @State private var hasChosenGetStarted = false
    
    var body: some View {
        if hasChosenGetStarted == false {
            LandingView(getStarted: $hasChosenGetStarted)
        } else {
            CustomTabView()
        }
    }
}

#Preview {
    OpeningView()
}
