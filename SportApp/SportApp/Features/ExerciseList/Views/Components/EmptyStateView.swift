//
//  EmptyStateView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

struct EmptyStateView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            VStack(spacing: 8) {
                Text("No exercises found")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(emptyStateMessage)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            
            if store.state.hasActiveFilters {
                Button(action: {
                    withAnimation {
                        store.clearAllFilters()
                    }
                }) {
                    Text("Clear Filters")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(Color.blue)
                        )
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
    
    private var emptyStateMessage: String {
        if store.state.hasActiveFilters {
            return "Try adjusting your filters or search terms"
        } else {
            return "Start by searching for exercises or selecting filters"
        }
    }
}
