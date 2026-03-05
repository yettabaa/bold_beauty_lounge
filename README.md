# Bold Beauty Lounge (MVP)

Application mobile pour un salon de spa construite avec Flutter. Ce projet est un Minimal Viable Product (MVP) développé dans le cadre d'un test technique pour un poste de Stagiaire Développeur Mobile.

### Prerequisites

- **Flutter SDK**: ^3.10.1
- **Dart SDK**
- **Android Studio / Xcode** (for mobile development)

### Installation

1.  **Clone the repository:**

    ```bash
    git clone <repository-url>
    cd bold_beauty_lounge
    ```

2.  **Install dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Code Generation:**
    This project uses `freezed` and `json_serializable`. You need to run the build runner to generate necessary code files.

    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Run the app:**

    ```bash
    flutter run
    ```

5.  **Build APK:**
    ```bash
    flutter build apk
    ```

## 🛠 Tech Stack

This project leverages a modern Flutter tech stack:

- **Framework**: Flutter
- **Language**: Dart
- **State Management**: BLoC (`flutter_bloc`)
- **Theme**: Support for **Dark & Light Mode** (handled via `ThemeData` and `lib/config/theme`)
- **Routing**: [go_router](https://pub.dev/packages/go_router)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it)
- **Functional Programming**: dartz (Either type for error handling)
- **Value Equality**: equatable & freezed

### State Management

This project uses **BLoC (Business Logic Component)**:

- **Flutter Bloc**: Used for feature-based state management (Services, Booking).
- _Why?_ It provides a clear separation of concerns, predictable state changes, and excellent testability for business logic.

### Dependency Injection

- **GetIt**: Used for Service Locator pattern ([lib/injection_container.dart](lib/injection_container.dart)). All external data sources, repositories, and BLoCs are registered here.

## 🏗 Architecture

The project follows **Clean Architecture** principles to ensure separation of concerns and maintainability.

### Module Structure (Feature-first)

The `lib/features/` directory contains independent modules (e.g., Booking, Services). Each feature consists of three layers:

1.  **Domain Layer (Inner Layer)**
    - **Entities**: Pure Dart classes describing the data.
    - **Repositories (Interfaces)**: Abstract definitions of how data is accessed.
    - **Use Cases**: Business logic classes that interact with repositories.
    - _Note_: This layer has NO dependencies on external libraries (Flutter, etc.).

2.  **Data Layer (Middle Layer)**
    - **Models**: Data Transfer Objects (DTOs) that extend Entities. Handles JSON serialization (`fromJson`/`toJson`).
    - **Data Sources**: Interfaces with external APIs (Remote) or Local Storage.
    - **Repositories (Implementation)**: Implements the domain repository interfaces. Coordinates data retrieval from data sources.

3.  **Presentation Layer (Outer Layer)**
    - **Bloc/Cubit**: Manages state and handles user events.
    - **Widgets/Pages**: UI components that listen to state changes.

### Folder Structure

```
lib/
├── config/                 # App configuration (routes, theme)
├── core/                   # Core functionality shared across features
│   ├── constants/          # App constants
│   ├── error/              # Failure classes & Exception handling
│   ├── network/            # Network info & clients
│   ├── presentation/       # Shared UI widgets
│   ├── strings/            # String constants
│   └── utils/              # Utility functions
├── features/               # Feature modules
│   ├── booking/            # Booking management feature
│   └── services/           # Services catalog feature
├── injection_container.dart# Dependency Injection setup (GetIt)
├── main.dart               # App entry point
```

## ⚠️ Points d'attention & Limitations

- **Mock Data**: Les données des services sont mockées localement via la couche repository Data (`mock_services_repository.dart`) afin de simuler un environnement réel sans backend.
- **MVP Status**: Cette application est un Minimum Viable Product. Certaines fonctionnalités comme l'authentification complète ou le paiement réel ne sont pas intégrées.
- **Assets**: Toutes les couleurs sont centralisées dans `lib/config/theme` et les assets dans le dossier `assets/`.
