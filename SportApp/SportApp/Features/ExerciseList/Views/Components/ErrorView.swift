//
//  ErrorView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// MARK: - Error View Component

struct ErrorView: View {
    let message: String
    let retry: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Oops! Something went wrong")
                .font(.headline)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: retry) {
                Text("Try Again")
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(
                        Capsule()
                            .fill(Color.blue)
                    )
            }
        }
        .padding(.vertical, 40)
        .frame(maxWidth: .infinity)
    }
}
