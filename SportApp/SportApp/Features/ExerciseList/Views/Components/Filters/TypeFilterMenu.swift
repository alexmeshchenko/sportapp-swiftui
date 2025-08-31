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

// MARK: - TypeFilterMenu

struct TypeFilterMenu: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        Menu {
            Button("All Types") {
                store.selectType(nil)
            }
            
            Divider()
            
            ForEach(ExerciseType.allCases, id: \.self) { type in
                Button(action: {
                    store.selectType(type.rawValue)
                }) {
                    HStack {
                        Text(type.displayName)
                        if store.state.selectedType == type.rawValue {
                            Image(systemName: "checkmark")
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
            return type.displayName.components(separatedBy: " ").last ?? "Type"
        }
}
