//
//  DifficultyFilterMenu.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// Фильтр по сложности
// Цветовая индикация (зеленый/оранжевый/красный)
// Визуальные индикаторы (точки показывают уровень)
// Кнопка меняет цвет в зависимости от выбранной сложности

struct DifficultyFilterMenu: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        Menu {
            // Clear selection
            Button("All Levels") {
                store.selectDifficulty(nil)
            }
            
            Divider()
            
            ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                Button(action: {
                    store.selectDifficulty(difficulty.rawValue)
                }) {
                    HStack {
                        Text(difficulty.displayName)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if store.state.selectedDifficulty == difficulty.rawValue {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        } label: {
            FilterButton(
                icon: DifficultyLevel.categoryIcon,
                title: currentDifficultyTitle,
                isActive: store.state.selectedDifficulty != nil,
                activeColor: currentDifficultyColor
            )
        }
    }
    
    private var currentDifficultyTitle: String {
        guard let selectedDifficulty = store.state.selectedDifficulty,
              let difficulty = DifficultyLevel.allCases.first(where: { $0.rawValue == selectedDifficulty }) else {
            return "Level"
        }
        return difficulty.displayName.components(separatedBy: " ").last ?? "Level"
    }
    
    private var currentDifficultyColor: Color {
        guard let selectedDifficulty = store.state.selectedDifficulty,
              let difficulty = DifficultyLevel(rawValue: selectedDifficulty) else {
            return .blue
        }
        return difficulty.color
    }
}
