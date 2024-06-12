//
//  ItemView.swift
//  Pomodoro
//
//  Created by Shuyu Zhou on 2024-06-11.
//

import SwiftUI

struct ItemView: View {
    
    @Binding var currentItem: Session
    
   //Access the view model through the environment
    @Environment(JournalViewModel.self) var viewModel
    
    var body: some View {
        Label(
            title: {
                TextField("", text: $currentItem.description, axis: .vertical)
//                    .onSubmit {
//                        viewModel.update(todo: currentItem)
//                    }
            }, icon: {
                Text("Tag")
                   
                
            }
        )
    }
}


