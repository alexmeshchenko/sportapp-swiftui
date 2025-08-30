//
//  TypeFilterMenu.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// фильтр типов упражнений
// Иконки для каждого типа
// Checkmark для выбранного

struct TypeFilterMenu: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        Menu {
            // Clear selection
            Button(action: {
                store.selectType(nil)
            }) {
                Label("All Types", systemImage: "square.dashed")
            }
            
            Divider()
            
            // Type options
            ForEach(ExerciseType.allCases, id: \.self) { type in
                Button(action: {
                    store.selectType(type.rawValue)
                }) {
                    HStack {
                        Label(type.displayName, systemImage: type.icon)
                        if store.state.selectedType == type.rawValue {
                            Spacer()
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        } label: {
            FilterButton(
                icon: "figure.run",
                title: currentTypeTitle,
                isActive: store.state.selectedType != nil
            )
        }
    }
    
    private var currentTypeTitle: String {
        guard let selectedType = store.state.selectedType,
              let type = ExerciseType.allCases.first(where: { $0.rawValue == selectedType }) else {
            return "Type"
        }
        // Убираем эмодзи, оставляем только название
        return type.displayName.components(separatedBy: " ").last ?? "Type"
    }
}
