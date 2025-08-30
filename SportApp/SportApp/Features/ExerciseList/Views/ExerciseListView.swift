//
//  ExerciseListView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import SwiftUI

struct ExerciseListView: View {
    @EnvironmentObject private var store: Store
    @State private var showingFilterInfo = false
    
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
                
                // Результаты
                ScrollView {
                    LazyVStack(spacing: 12) {
                        if store.state.isLoading {
                            ProgressView("Loading exercises...")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 40)
                        } else if let error = store.state.errorMessage {
                            ErrorView(message: error) {
                                Task {
                                    await store.fetchExercises()
                                }
                            }
                        } else if store.state.filteredExercises.isEmpty {
                            EmptyStateView()
                                .padding(.vertical, 40)
                        } else {
                            ForEach(store.state.filteredExercises) { exercise in
                                ExerciseCard(exercise: exercise)
                                    .padding(.horizontal)
                            }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Sport App")
        }
        .task {
            // Загружаем упражнения при первом запуске
            if store.state.exercises.isEmpty {
                await store.fetchExercises()
            }
        }
    }
}

struct ExerciseListView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseListView()
            .environmentObject(Store())
    }
}
