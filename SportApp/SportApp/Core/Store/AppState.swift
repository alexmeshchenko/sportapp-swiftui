//
//  AppState.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import Foundation

struct AppState {
    // Данные
    var exercises: [Exercise] = []
    
    // Фильтры и поиск
    var searchText: String = ""
    var selectedType: String? = nil
    var selectedMuscle: String? = nil
    var selectedDifficulty: String? = nil
    
    // UI состояния
    var isLoading: Bool = false
    var errorMessage: String? = nil
    
    // Вычисляемые свойства
    var filteredExercises: [Exercise] {
        exercises.filter { exercise in
            // Поиск по названию
            let matchesSearch = searchText.isEmpty || 
                exercise.name.lowercased().contains(searchText.lowercased())
            
            // Фильтр по типу
            let matchesType = selectedType == nil || 
                exercise.type == selectedType
            
            // Фильтр по мышцам
            let matchesMuscle = selectedMuscle == nil || 
                exercise.muscle == selectedMuscle
            
            // Фильтр по сложности
            let matchesDifficulty = selectedDifficulty == nil || 
                exercise.difficulty == selectedDifficulty
            
            return matchesSearch && matchesType && matchesMuscle && matchesDifficulty
        }
    }
    
    var hasActiveFilters: Bool {
        !searchText.isEmpty || 
        selectedType != nil || 
        selectedMuscle != nil || 
        selectedDifficulty != nil
    }
    
//    var activeFiltersCount: Int {
//        var count = 0
//        if !searchText.isEmpty { count += 1 }
//        if selectedType != nil { count += 1 }
//        if selectedMuscle != nil { count += 1 }
//        if selectedDifficulty != nil { count += 1 }
//        return count
//    }
}
