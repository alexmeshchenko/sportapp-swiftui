//
//  MainView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 31.08.25.
//

import SwiftUI

// Главный экран приложения
// композиция всего экрана

struct MainView: View {  // Или SportAppMainView
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Поиск
                SearchBarView(
                    text: Binding(
                        get: { store.state.searchText },
                        set: { store.updateSearchText($0) }
                    )
                )
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                // Панель фильтров
                FilterBarView()
                    .environmentObject(store)
                
                Divider()
                
                // Результаты поиска
                ExerciseListView()  // <- Теперь это отдельный компонент
                    .environmentObject(store)
            }
            .navigationTitle("Sport App")
            .navigationBarTitleDisplayMode(.large)
        }
        .task {
            if store.state.exercises.isEmpty {
                await store.fetchExercises()
            }
        }
    }
}
