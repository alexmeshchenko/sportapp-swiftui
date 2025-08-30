//
//  SearchBarView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search exercises...", text: $text)
                .textFieldStyle(PlainTextFieldStyle())
                .focused($isFocused)
                .submitLabel(.search)
                .onSubmit {
                    isFocused = false
                }
            
            if !text.isEmpty {
                Button(action: {
                    withAnimation {
                        text = ""
                    }
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemGray6))
        )
    }
}
