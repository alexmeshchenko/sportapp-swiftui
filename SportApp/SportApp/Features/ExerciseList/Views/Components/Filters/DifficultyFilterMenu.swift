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
            
            // Difficulty options с визуальными индикаторами
            ForEach(DifficultyLevel.allCases, id: \.self) { difficulty in
                Button(action: {
                    store.selectDifficulty(difficulty.rawValue)
                }) {
                    HStack {
                        Label {
                            HStack {
                                Text(difficulty.displayName)
                                // Визуальный индикатор сложности
                                difficultyIndicator(for: difficulty)
                            }
                        } icon: {
                            Image(systemName: difficulty.icon)
                                .foregroundColor(difficulty.color)
                        }
                        
                        if store.state.selectedDifficulty == difficulty.rawValue {
                            Spacer()
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
    
    private func difficultyIndicator(for difficulty: DifficultyLevel) -> some View {
        HStack(spacing: 2) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(index < difficulty.level ?
                          difficulty.color : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
        }
    }

}
