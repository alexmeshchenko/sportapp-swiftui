//
//  FilterBarView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

struct FilterBarView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // Type Filter
                TypeFilterMenu()
                    .environmentObject(store)
                
                // Muscle Filter
                MuscleFilterMenu()
                    .environmentObject(store)
                
                // Difficulty Filter
                DifficultyFilterMenu()
                    .environmentObject(store)
                
                // Clear button
                if store.state.hasActiveFilters {
                    // Clear all button
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            store.clearAllFilters()
                        }
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 22))  // Увеличили размер
                            .foregroundColor(.red)
                            .frame(width: 44, height: 44)  // Минимальная touch target 44x44
                            .contentShape(Rectangle())  // Вся область кликабельна
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding(.horizontal)
        }
        .frame(height: 50)
        .background(Color(.systemBackground))
    }
}

struct FilterBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FilterBarView()
                .environmentObject(Store())
            
            Spacer()
        }
    }
}
