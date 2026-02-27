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

## 🧪 TESTING & MOCKING
Every feature comes with a pre-generated test file template in `test/features/{name}/`. 

**Testing Architecture (BLoC & Mockito):**
When testing BLoC components, always stick to this specific pattern using `bloc_test` and mocked repositories:

1. **Setup Mocks**: Use `mockito` to create a mock of the Domain Repository (e.g., `MockI{Name}Repository`).
2. **Setup BLoC**: Initialize your BLoC in the `setUp` function, injecting the mock repository.
3. **Use `blocTest`**: Define the `build` phase (stubbing repository responses with `when().thenAnswer()`), the `act` phase (adding events), and the `expect` phase (verifying the sequence of emitted states).

**Example Test Pattern:**
```dart
void main() {
  late {Name}Bloc bloc;
  late MockI{Name}Repository mockRepository;

  setUp(() {
    mockRepository = MockI{Name}Repository();
    bloc = {Name}Bloc(repository: mockRepository);
  });

  group('{Name}Bloc Tests', () {
    blocTest<{Name}Bloc, {Name}State>(
      'emits [{Name}Loading, {Name}Loaded] when data is fetched successfully',
      build: () {
        when(mockRepository.getData()).thenAnswer((_) async => Data());
        return bloc;
      },
      act: (bloc) => bloc.add(FetchDataEvent()),
      expect: () => [isA<{Name}Loading>(), isA<{Name}Loaded>()],
    );

    blocTest<{Name}Bloc, {Name}State>(
      'emits [{Name}Loading, {Name}Error] when fetching data fails (throws exception)',
      build: () {
        when(mockRepository.getData()).thenThrow(Exception('Failed to fetch data'));
        return bloc;
      },
      act: (bloc) => bloc.add(FetchDataEvent()),
      expect: () => [isA<{Name}Loading>(), isA<{Name}Error>()],
    );
  });
}
```

Run tests using: `flutter test test/features/{name}/{name}_test.dart`

## 🔄 POST-GENERATION
After running the mason command, ALWAYS run build_runner:
`dart run build_runner build -d`
