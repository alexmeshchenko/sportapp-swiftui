//
//  Store.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import Foundation
import Combine

@MainActor
class Store: ObservableObject {
    @Published private(set) var state = AppState()
    
    private let exerciseService = ExerciseService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        // Можно добавить дебаунс для поиска
        setupSearchDebounce()
    }
    
    // MARK: - Actions
    
    func updateSearchText(_ text: String) {
        state.searchText = text
    }
    
    func selectType(_ type: String?) {
        state.selectedType = type
        Task {
            await fetchExercises()
        }
    }
    
    func selectMuscle(_ muscle: String?) {
        state.selectedMuscle = muscle
        Task {
            await fetchExercises()
        }
    }
    
    func selectDifficulty(_ difficulty: String?) {
        state.selectedDifficulty = difficulty
        Task {
            await fetchExercises()
        }
    }
    
    func clearAllFilters() {
        state.searchText = ""
        state.selectedType = nil
        state.selectedMuscle = nil
        state.selectedDifficulty = nil
        Task {
            await fetchExercises()
        }
    }
    
    func fetchExercises() async {
        state.isLoading = true
        state.errorMessage = nil
        
        do {
            let exercises = try await exerciseService.fetchExercises(
                name: state.searchText.isEmpty ? nil : state.searchText,
                type: state.selectedType,
                muscle: state.selectedMuscle,
                difficulty: state.selectedDifficulty
            )
            state.exercises = exercises
        } catch {
            state.errorMessage = error.localizedDescription
        }
        
        state.isLoading = false
    }
    
    // MARK: - Private
    
    private func setupSearchDebounce() {
        $state
            .map { $0.searchText }
            .removeDuplicates()
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                Task { [weak self] in
                    await self?.fetchExercises()
                }
            }
            .store(in: &cancellables)
    }
}