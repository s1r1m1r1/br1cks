---
name: feature-first-bloc-app 
description: Strict Feature-First directory layout for Flutter.
---

# 🏗 PROJECT ARCHITECTURE: MODULAR FEATURE-FIRST (DDD-LITE)
This project follows a Modular Feature-First architecture with Clean Architecture (DDD-Lite) principles. 
All code must live inside `lib/features/`. NEVER put business logic in `lib/` root.

## 1. DIRECTORY MAP (КАРТА ПАПОК)
Follow this exact nesting for every new feature:

```text
lib/
├── core/                # Global infrastructure (network, database client, theme, di)
│   ├── database/        # Main AppDatabase, migrations, common converters
│   ├── network/         # HttpClient, Interceptors, DTOs (if shared)
│   └── error/           # Global Failures & Exceptions
├── shared/              # Reusable UI components & constants (across features)
└── features/
    └── {feature_name}/  # Individual feature modules
        ├── data/        # DATA LAYER: External logic, API calls, DB DAOs
        │   ├── database/# Feature-specific Drift tables & DAOs
        │   ├── source/   # Remote/Local sources (API/DataSources)
        │   └── repositories/# Repository implementations
        ├── domain/      # DOMAIN LAYER (OPTIONAL): Pure business logic 
        │   ├── models/  # Freezed Entities (not DTOs!)
        │   └── repositories/# Repository Interfaces (Abstract)
        └── presentation/ # UI LAYER
            ├── bloc/    # BLoC state management (Split into bloc/event/state)
            ├── pages/   # Screens/Views
            └── widgets/ # Feature-specific UI components
```

## 2. KEY ARCHITECTURAL RULES
1. **Presentation** communicates only with **Repositories** (never directly with sources or DB).
2. **Data Layer** handles mapping from DTOs to Domain Entities.
3. **Core** layer is for code shared by EVERY feature (singleton database, global theme).
```