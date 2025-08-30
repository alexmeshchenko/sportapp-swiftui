//
//  ExerciseListView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import SwiftUI

// Список с логикой состояний
// управление состояниями списка

// Теперь можно отдельно тестировать список

// MARK: - ExerciseListView

struct ExerciseListView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                if store.state.isLoading {
                    LoadingView()
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
                    ExerciseResultsView(exercises: store.state.filteredExercises)
                }
            }
            .padding(.vertical)
        }
    }
}

//struct ExerciseListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseListView()
//            .environmentObject(Store())
//    }
//}
