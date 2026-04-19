# Bold Beauty Lounge (MVP)

Mobile application for a spa and beauty salon built with Flutter, designed as a Minimum Viable Product (MVP) and structured using Clean Architecture principles to ensure scalability, maintainability, and a clear separation of concerns across the system.

### Prerequisites

- **Flutter SDK**: ^3.10.1
- **Dart SDK**
- **Android Studio / Xcode** (for mobile development)

### Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd bold_beauty_lounge
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Code generation (required for freezed & json_serializable):**

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app:**

   ```bash
   flutter run
   ```

5. **Build APK:**
   ```bash
   flutter build apk
   ```

## 🛠 Tech Stack

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: BLoC (`flutter_bloc`)
- **Routing**: `go_router`
- **Dependency Injection**: `get_it`
- **Functional Programming**: `dartz` (Either type)
- **Data Models**: `freezed` + `json_serializable`
- **Equality Handling**: `equatable`

## 🧠 State Management

The application uses **BLoC (Business Logic Component)**:

- Handles feature-level state (e.g. Services, Booking)
- Ensures predictable state transitions
- Improves testability and separation of UI vs business logic

## 🔌 Dependency Injection

Implemented using **GetIt** (Service Locator pattern), centralized in: [lib/injection_container.dart](lib/injection_container.dart). It registers:

- Data sources
- Repositories
- Use cases
- BLoCs

## 🏗 Architecture Overview

The project follows **Clean Architecture + Feature-first** structure, split into 3 main layers:

### 1. 📦 Domain Layer (Core Business Logic)

- **Responsibilities**: Defines business rules, independent of Flutter and external libraries.
- **Contains**: Entities, Repository interfaces, Use cases.
- **Design Patterns**: Repository Pattern (Abstraction), Use Case / Interactor Pattern, Entity Pattern.
- **Purpose**: This layer is framework-independent and represents the core business logic.

### 2. 💾 Data Layer (Infrastructure Layer)

- **Responsibilities**: Handles external data sources (API, mock, local storage), implements domain repositories.
- **Contains**: Models (DTOs), Data sources (remote/local), Repository implementations.
- **Design Patterns**: Repository Pattern (Implementation), Data Source Pattern, Data Mapper Pattern, Adapter Pattern.
- **Purpose**: Acts as a bridge between domain logic and external systems.

### 3. 🎨 Presentation Layer (UI Layer)

- **Responsibilities**: UI rendering, user interaction handling, state management.
- **Contains**: BLoC / Cubit, Pages, Widgets.
- **Design Patterns**: BLoC Pattern (Observer Pattern), MVVM-like Separation (Conceptual), Builder Pattern.
- **Purpose**: Keeps UI reactive, clean, and testable.

## 📁 Folder Structure

```
lib/
├── config/                 # App configuration (routes, theme)
├── core/                   # Shared core utilities
│   ├── constants/
│   ├── error/
│   ├── network/
│   ├── presentation/
│   ├── strings/
│   └── utils/
├── features/               # Feature modules (vertical slicing)
│   ├── booking/
│   └── services/
├── injection_container.dart
├── main.dart
```

## ⚠️ Limitations & Notes

- **Mock Data Only**: Services are currently simulated via `mock_services_repository.dart`.
- **MVP Scope**: No real authentication system or payment gateway integration.
- **Theming**: Centralized in `lib/config/theme`.
