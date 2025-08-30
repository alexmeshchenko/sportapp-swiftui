//
//  FilterButton.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import SwiftUI

// Переиспользуемая кнопка
// Анимация поворота chevron при активации
// Настраиваемый цвет активного состояния

struct FilterButton: View {
    let icon: String
    let title: String
    let isActive: Bool
    var activeColor: Color = .blue
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 14))
            
            Text(title)
                .font(.system(size: 15, weight: .medium))
            
            Image(systemName: "chevron.down")
                .font(.system(size: 10))
                .rotationEffect(.degrees(isActive ? 180 : 0))
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(isActive ? activeColor : Color(.systemGray6))
        )
        .foregroundColor(isActive ? .white : .primary)
        .animation(.easeInOut(duration: 0.2), value: isActive)
    }
}
