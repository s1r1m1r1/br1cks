---
name: flutter-feature-expert
description: Complete Feature generation with Clean Architecture layers and tests.
---

# 🚀 FLUTTER FEATURE EXPERT (CLEAN ARCHITECTURE)

This skill describes how to generate and manage a complete feature module using the `flutter_feature` brick.

## 🧱 AUTOMATED GENERATION (MASON)
To generate a complete feature with all layers and tests:

`mason make flutter_feature --name={feature_name} --no-hooks`

**CRITICAL**: Always run from the project root. This command creates:
- `lib/features/{name}/data/` (Repositories & Sources)
- `lib/features/{name}/domain/` (Entities & Interfaces)
- `lib/features/{name}/presentation/` (BLoC, Pages, Widgets)
- `test/features/{name}/` (Directly in the test folder)

## 🏗 LAYER INTERACTION
1. **Presentation Layer**: 
   - `Pages` use `BlocBuilder/BlocListener` to react to state.
   - `Bloc` depends on `Domain Interfaces` (I{Name}Repository).
2. **Domain Layer**: 
   - Contains pure business logic and abstract repository interfaces.
   - Models are defined using `Freezed`.
3. **Data Layer**: 
   - Implements `Domain Interfaces`.
   - Communicates with APIs or Database (Drift).

## 🧪 TESTING
Every feature comes with a pre-generated test file in `test/features/{name}/`. 
Run tests using: `flutter test test/features/{name}/{name}_test.dart`

## 🔄 POST-GENERATION
After running the mason command, ALWAYS run build_runner:
`dart run build_runner build -d`
