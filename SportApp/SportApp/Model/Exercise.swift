//
//  Exercise.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import Foundation

struct Exercise: Codable, Identifiable, Equatable {
    let id = UUID()
    let name: String
    let type: String
    let muscle: String
    let equipment: String
    let difficulty: String
    let instructions: String
    
    enum CodingKeys: String, CodingKey {
        case name, type, muscle, equipment, difficulty, instructions
    }
    
    // Для Identifiable
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        muscle = try container.decode(String.self, forKey: .muscle)
        equipment = try container.decode(String.self, forKey: .equipment)
        difficulty = try container.decode(String.self, forKey: .difficulty)
        instructions = try container.decode(String.self, forKey: .instructions)
    }
}