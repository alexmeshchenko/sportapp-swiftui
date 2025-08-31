//
//  ExerciseService.swift
//  SportApp
//
//  Created by Aleksandr Meshchenko on 30.08.25.
//

import Foundation

class ExerciseService {
    private let session = URLSession.shared
    
    func fetchExercises(
        name: String? = nil,
        type: String? = nil,
        muscle: String? = nil,
        difficulty: String? = nil,
        offset: Int = 0
    ) async throws -> [Exercise] {
        
        // Проверяем что API ключ установлен
        guard APIConfig.apiKey != "YOUR_API_KEY_HERE" else {
            print("⚠️ ERROR: API Key not set! Please add your API key to APIConfig.swift")
            throw NetworkError.missingAPIKey
        }
        
        var components = URLComponents(string: APIConfig.baseURL + APIConfig.exercisesEndpoint)!
        var queryItems: [URLQueryItem] = []
        
        if let name = name, !name.isEmpty {
            queryItems.append(URLQueryItem(name: "name", value: name))
        }
        if let type = type {
            queryItems.append(URLQueryItem(name: "type", value: type))
        }
        if let muscle = muscle {
            queryItems.append(URLQueryItem(name: "muscle", value: muscle))
        }
        if let difficulty = difficulty {
            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty))
        }
        if offset > 0 {
            queryItems.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        components.queryItems = queryItems.isEmpty ? nil : queryItems
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        // Debug: печатаем URL для проверки
        print("🌐 Fetching from URL: \(url.absoluteString)")
        
        var request = URLRequest(url: url)
        APIConfig.headers.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            print("📡 Response status code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                // Если 401 - проблема с API ключом
                if httpResponse.statusCode == 401 {
                    print("❌ Authentication failed. Check your API key!")
                    throw NetworkError.authenticationFailed
                }
                throw NetworkError.httpError(httpResponse.statusCode)
            }
            
            // Debug: печатаем размер полученных данных
            print("✅ Received \(data.count) bytes")
            
            // Попробуем распечатать JSON для отладки
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📝 Response preview: \(jsonString.prefix(200))...")
            }
            
            let exercises = try JSONDecoder().decode([Exercise].self, from: data)
            print("✅ Decoded \(exercises.count) exercises")
            return exercises
            
        } catch {
            print("❌ Network error: \(error.localizedDescription)")
            throw error
        }
    }
}

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(Int)
    case missingAPIKey
    case authenticationFailed
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .httpError(let code):
            return "HTTP error: \(code)"
        case .missingAPIKey:
            return "API Key not configured. Please add your API key to APIConfig.swift"
        case .authenticationFailed:
            return "Authentication failed. Please check your API key."
        }
    }
}
