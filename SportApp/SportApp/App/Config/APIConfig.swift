//
//  APIConfig.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//


import Foundation

enum APIConfig {
    static let baseURL = "https://api.api-ninjas.com/v1"
    static let exercisesEndpoint = "/exercises"
    
    // TODO: Получи ключ на https://api-ninjas.com/api/exercises
    static let apiKey = "mHgXgvSADq9GAxk5ICrBFA==dwSZmcx4DewiWjBR"
    
    static var headers: [String: String] {
        ["X-Api-Key": apiKey]
    }
}
