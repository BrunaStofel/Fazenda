# Project Guidelines

## Code Style
- Follow flutter_lints rules (analysis_options.yaml)
- Naming: snake_case files, PascalCase classes, camelCase methods
- Use const for performance

## Architecture
- Clean Architecture simplified: Domain/Data/Presentation layers
- Feature-first organization: features/talhoes/ with data/domain/presentation subfolders
- Dependency: presentation -> domain <- data
- State management: Riverpod/Provider/Bloc (choose one consistently)
- HTTP: Use Dio or http via datasource layer, not directly in UI

## Build and Test
- flutter pub get
- flutter test
- flutter run
- flutter analyze

## Conventions
- Error handling: Either<Failure, T> or Result<T>
- Navigation: Centralized routes
- Models: Entities in domain, Models in data for JSON conversion
- Testing: Unit for domain/usecases, widget tests for critical screens

See [documentation/architeture.md](documentation /architeture.md) for detailed architecture, [documentation/features.md](documentation /features.md) for features.