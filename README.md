# Sport App

A SwiftUI-based iOS application for discovering and tracking exercises with smart filtering capabilities.

## 📱 Overview

Sport App is a modern exercise discovery platform that helps users find the perfect workout based on exercise type, target muscle groups, and difficulty level.

## ✨ Features

### Core Functionality
- **Exercise Search** - Real-time search by exercise name
- **Smart Filtering** - Filter by type, muscle group, and difficulty level
- **Detailed Instructions** - Expandable exercise instructions with proper formatting
- **Clean UI** - Modern, intuitive interface following iOS design guidelines

### Filter Categories
- **Exercise Types**: Cardio, Strength, Stretching, Plyometrics, Powerlifting, Olympic Weightlifting, Strongman
- **Muscle Groups**: 16 different muscle groups organized by body sections
- **Difficulty Levels**: Beginner, Intermediate, Expert with color-coded indicators

##  Tech Stack

- **Platform**: iOS 16.0+
- **Framework**: SwiftUI
- **Architecture**: Unidirectional Data Flow (Redux-like)
- **Language**: Swift 5.9
- **API**: API Ninjas Exercise Database
- **Xcode**: 16.0+

### Setup Steps

1. **Clone the repository**
```bash
git clone https://github.com/alexmeshchenko/sportapp-swiftui.git
cd SportApp
```

2. **Open in Xcode**
```bash
open SportApp.xcodeproj
```

3. **Configure API Key**
   - Sign up at [API Ninjas](https://api-ninjas.com/api/exercises)
   - Get your free API key
   - Add it to `App/Config/APIConfig.swift`:
```swift
static let apiKey = "YOUR_API_KEY_HERE"
```

4. **Build and Run**
   - Select your target device/simulator
   - Press `Cmd + R` to build and run

##  Architecture

### UDF (Unidirectional Data Flow)

The app follows a simplified Redux-like pattern:

```
View → Action → Store → State → View
```

- **Store**: Single source of truth for app state
- **State**: Immutable data structure containing all app data
- **Actions**: User interactions that trigger state changes
- **Views**: SwiftUI views that react to state changes

##  Key Components

### State Management
- `AppState` - Central state container
- `Store` - ObservableObject managing state mutations
- Computed properties for filtered results

### UI Components
- `MainView` - App composition and navigation
- `ExerciseListView` - Handles loading states and results display
- `FilterBarView` - Horizontal scrollable filter menu
- `ExerciseCard` - Individual exercise display with expandable details

### Networking
- `ExerciseService` - Async/await based API client
- Proper error handling and loading states
- Query parameter construction for filters

## API Integration

The app uses API Ninjas Exercise Database:
- **Endpoint**: `https://api.api-ninjas.com/v1/exercises`
- **Rate Limit**: 10,000 requests/month (free tier)
- **Response**: Maximum 10 exercises per request
- **Authentication**: X-Api-Key header

## License

This project is available under the MIT License. See the LICENSE file for more info.

## Credits

- Exercise data provided by [API Ninjas](https://api-ninjas.com)

