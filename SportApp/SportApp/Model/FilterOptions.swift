//
//  FilterOptions.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import Foundation

// Типы упражнений
enum ExerciseType: String, CaseIterable {
    case cardio = "cardio"
    case olympicWeightlifting = "olympic_weightlifting"
    case plyometrics = "plyometrics"
    case powerlifting = "powerlifting"
    case strength = "strength"
    case stretching = "stretching"
    case strongman = "strongman"
    
    var displayName: String {
        switch self {
        case .cardio: return "🏃 Cardio"
        case .olympicWeightlifting: return "🏅 Olympic"
        case .plyometrics: return "🤾 Plyometrics"
        case .powerlifting: return "🏋️ Powerlifting"
        case .strength: return "💪 Strength"
        case .stretching: return "🧘 Stretching"
        case .strongman: return "💯 Strongman"
        }
    }
    
    var icon: String {
        switch self {
        case .cardio: return "figure.run"
        case .strength: return "figure.strengthtraining.traditional"
        case .stretching: return "figure.yoga"
        default: return "figure.mixed.cardio"
        }
    }
}

// Мышечные группы
enum MuscleGroup: String, CaseIterable {
    case abdominals = "abdominals"
    case abductors = "abductors"
    case adductors = "adductors"
    case biceps = "biceps"
    case calves = "calves"
    case chest = "chest"
    case forearms = "forearms"
    case glutes = "glutes"
    case hamstrings = "hamstrings"
    case lats = "lats"
    case lowerBack = "lower_back"
    case middleBack = "middle_back"
    case neck = "neck"
    case quadriceps = "quadriceps"
    case traps = "traps"
    case triceps = "triceps"
    
    var displayName: String {
        switch self {
        case .abdominals: return "🧘 Abs"
        case .biceps: return "💪 Biceps"
        case .chest: return "🫁 Chest"
        case .glutes: return "🍑 Glutes"
        case .quadriceps: return "🦵 Quads"
        case .hamstrings: return "🦵 Hamstrings"
        case .calves: return "🦵 Calves"
        case .lowerBack: return "🔙 Lower Back"
        case .middleBack: return "🔙 Mid Back"
        case .triceps: return "💪 Triceps"
        case .traps: return "🤷 Traps"
        case .lats: return "🔙 Lats"
        case .forearms: return "💪 Forearms"
        case .neck: return "🦒 Neck"
        case .abductors: return "🦵 Abductors"
        case .adductors: return "🦵 Adductors"
        }
    }
}

// Уровни сложности
enum DifficultyLevel: String, CaseIterable {
    case beginner = "beginner"
    case intermediate = "intermediate"
    case expert = "expert"
    
    var displayName: String {
        switch self {
        case .beginner: return "🌱 Beginner"
        case .intermediate: return "📈 Intermediate"
        case .expert: return "🔥 Expert"
        }
    }
    
    var color: String {
        switch self {
        case .beginner: return "green"
        case .intermediate: return "orange"
        case .expert: return "red"
        }
    }
}
