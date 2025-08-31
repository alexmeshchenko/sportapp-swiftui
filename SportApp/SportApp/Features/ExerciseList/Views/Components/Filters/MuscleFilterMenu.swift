//
//  MuscleFilterMenu.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// Фильтр по мышцам
// Группировка по категориям (Upper Body, Lower Body, Core & Back)
// MARK: - MuscleFilterMenu

struct MuscleFilterMenu: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        Menu {
            Button("All Muscles") {
                store.selectMuscle(nil)
            }
            
            Divider()
            
            Section("Upper Body") {
                ForEach(upperBodyMuscles, id: \.self) { muscle in
                    muscleButton(muscle)
                }
            }
            
            Section("Lower Body") {
                ForEach(lowerBodyMuscles, id: \.self) { muscle in
                    muscleButton(muscle)
                }
            }
            
            Section("Core & Back") {
                ForEach(coreBackMuscles, id: \.self) { muscle in
                    muscleButton(muscle)
                }
            }
        } label: {
            FilterButton(
                icon: MuscleGroup.categoryIcon,
                title: currentMuscleTitle,
                isActive: store.state.selectedMuscle != nil
            )
        }
    }
    
    private func muscleButton(_ muscle: MuscleGroup) -> some View {
        Button(action: {
            store.selectMuscle(muscle.rawValue)
        }) {
            HStack {
                Text(muscle.displayName)
                if store.state.selectedMuscle == muscle.rawValue {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
    
    private var currentMuscleTitle: String {
        guard let selectedMuscle = store.state.selectedMuscle,
              let muscle = MuscleGroup.allCases.first(where: { $0.rawValue == selectedMuscle }) else {
            return "Muscle"
        }
        return muscle.displayName  
    }
    
    private var upperBodyMuscles: [MuscleGroup] {
        [.biceps, .triceps, .chest, .forearms, .traps]
    }
    
    private var lowerBodyMuscles: [MuscleGroup] {
        [.quadriceps, .hamstrings, .glutes, .calves, .abductors, .adductors]
    }
    
    private var coreBackMuscles: [MuscleGroup] {
        [.abdominals, .lats, .lowerBack, .middleBack, .neck]
    }
}
