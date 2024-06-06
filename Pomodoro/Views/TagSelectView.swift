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
        List {
            ForEach(tags, id: \.self) { tag in
                HStack {
                    Text(tag)
                    Spacer()
                    if tag == selectedTag {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedTag = tag
                }
            }
        }
        .navigationTitle("Select Tag")
    }
}
