//
//  MedalDetailView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-05-30.
//

import SwiftUI

struct MedalDetailView: View {
    var body: some View {
        Image("NewMedal")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

#Preview {
    MedalDetailView()
}
