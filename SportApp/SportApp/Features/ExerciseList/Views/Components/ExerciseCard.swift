//
//  ExerciseCard.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

struct ExerciseCard: View {
    let exercise: Exercise
    @State private var isExpanded = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(exercise.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                    
                    HStack(spacing: 12) {
                        // Type badge
                        Label {
                            Text(formatType(exercise.type))
                        } icon: {
                            Image(systemName: "figure.mixed.cardio")
                        }
                        .font(.caption)
                        .foregroundColor(.secondary)
                        
                        // Equipment badge
                        if !exercise.equipment.isEmpty && exercise.equipment != "body_only" {
                            Label {
                                Text(formatEquipment(exercise.equipment))
                            } icon: {
                                Image(systemName: "dumbbell.fill")
                            }
                            .font(.caption)
                            .foregroundColor(.secondary)
                        }
                    }
                }
                
                Spacer()
                
                // Difficulty indicator
                VStack(alignment: .trailing, spacing: 4) {
                    Image(systemName: difficultyIcon)
                        .foregroundColor(difficultyColor)
                    Text(exercise.difficulty.capitalized)
                        .font(.caption2)
                        .foregroundColor(difficultyColor)
                }
            }
            
            // Muscle and details
            HStack(spacing: 16) {
                Label {
                    Text(formatMuscle(exercise.muscle))
                } icon: {
                    Image(systemName: "figure.strengthtraining.traditional")
                }
                .font(.subheadline)
                .foregroundColor(.blue)
            }
            
            // Instructions (expandable)
            if !exercise.instructions.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text(exercise.instructions)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(isExpanded ? nil : 2)
                        .animation(.easeInOut, value: isExpanded)
                    
                    Button(action: {
                        withAnimation {
                            isExpanded.toggle()
                        }
                    }) {
                        Text(isExpanded ? "Show less" : "Show more")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        )
    }
    
    private var difficultyColor: Color {
        switch exercise.difficulty {
        case "beginner": return .green
        case "intermediate": return .orange
        case "expert": return .red
        default: return .gray
        }
    }
    
    private var difficultyIcon: String {
        switch exercise.difficulty {
        case "beginner": return "1.circle.fill"
        case "intermediate": return "2.circle.fill"
        case "expert": return "3.circle.fill"
        default: return "questionmark.circle.fill"
        }
    }
    
    private func formatType(_ type: String) -> String {
        type.replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    private func formatMuscle(_ muscle: String) -> String {
        muscle.replacingOccurrences(of: "_", with: " ").capitalized
    }
    
    private func formatEquipment(_ equipment: String) -> String {
        equipment.replacingOccurrences(of: "_", with: " ").capitalized
    }
}
