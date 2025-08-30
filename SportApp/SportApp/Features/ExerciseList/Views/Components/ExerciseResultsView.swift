//
//  ExerciseResultsView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 31.08.25.
//

import SwiftUI

// чистое отображение результатов (чистый презентационный компонент)
// Теперь можно передать моковые данные в ExerciseResultsView

struct ExerciseResultsView: View {
    let exercises: [Exercise]
    
    var body: some View {
        ForEach(exercises) { exercise in
            ExerciseCard(exercise: exercise)
                .padding(.horizontal)
        }
    }
}
