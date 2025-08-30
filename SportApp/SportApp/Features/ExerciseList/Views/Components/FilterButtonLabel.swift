//
//  FilterButtonLabel.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// MARK: - Filter Button Label Component

struct FilterButtonLabel: View {
    let icon: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
            Text(title)
                .font(.system(size: 15, weight: .medium))
            Image(systemName: "chevron.down")
                .font(.system(size: 10))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isActive ? Color.blue : Color(.systemGray6))
        )
        .foregroundColor(isActive ? .white : .primary)
        .animation(.easeInOut(duration: 0.2), value: isActive)
    }
}
