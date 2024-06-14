//
//  TagSelectView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-06.
//

import SwiftUI

struct TagSelectionView: View {
    @Binding var selectedTag: String
    let tags = ["Work", "Personal", "Exercise", "Shopping", "Other"]
    
    var body: some View {
        List(tags, id: \.self) { tag in
            Text(tag)
                .onTapGesture {
                    selectedTag = tag
                    
                }
        }
    }
}
