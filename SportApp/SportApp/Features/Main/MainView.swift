//
//  MainView.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 31.08.25.
//

import SwiftUI

// MARK: - MainView

struct MainView: View {
    @EnvironmentObject private var store: Store
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                SearchBarView(
                    text: Binding(
                        get: { store.state.searchText },
                        set: { store.updateSearchText($0) }
                    )
                )
                .padding(.horizontal)
                .padding(.vertical, 8)
                
                FilterBarView()
                    .environmentObject(store)
                
                Divider()
                
                ExerciseListView()
                    .environmentObject(store)
            }
            //.navigationTitle("Sport App")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "figure.run.circle.fill")
                            .foregroundColor(.blue)
                        Text("Sport App")
                            .font(.headline)
                    }
                }
            }
        }
        .task {
            if store.state.exercises.isEmpty {
                await store.fetchExercises()
            }
        }
    }
}
