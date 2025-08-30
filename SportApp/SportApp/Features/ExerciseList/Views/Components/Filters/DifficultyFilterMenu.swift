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
            Button(action: {
                store.selectDifficulty(nil)
            }) {
                Label("All Levels", systemImage: "square.dashed")
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
                            Image(systemName: difficultyIcon(for: difficulty))
                                .foregroundColor(difficultyColor(for: difficulty))
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
                icon: "chart.bar.fill",
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
        guard let selectedDifficulty = store.state.selectedDifficulty else {
            return .blue
        }
        
        switch selectedDifficulty {
        case "beginner": return .green
        case "intermediate": return .orange
        case "expert": return .red
        default: return .blue
        }
    }
    
    private func difficultyIndicator(for difficulty: DifficultyLevel) -> some View {
        HStack(spacing: 2) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(index < difficultyStars(for: difficulty) ? 
                          difficultyColor(for: difficulty) : Color.gray.opacity(0.3))
                    .frame(width: 6, height: 6)
            }
        }
    }
    
    private func difficultyStars(for difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .beginner: return 1
        case .intermediate: return 2
        case .expert: return 3
        }
    }
    
    private func difficultyIcon(for difficulty: DifficultyLevel) -> String {
        switch difficulty {
        case .beginner: return "1.circle.fill"
        case .intermediate: return "2.circle.fill"
        case .expert: return "3.circle.fill"
        }
    }
    
    private func difficultyColor(for difficulty: DifficultyLevel) -> Color {
        switch difficulty {
        case .beginner: return .green
        case .intermediate: return .orange
        case .expert: return .red
        }
    }
}
