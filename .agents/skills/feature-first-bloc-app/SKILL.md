---
name: feature-first-bloc-app 
description: Strict Feature-First directory layout for Flutter.
---

# 🏗 PROJECT ARCHITECTURE: FEATURE-FIRST
All code must live inside `lib/features/`. NEVER put business logic in `lib/` root.

## 1. DIRECTORY MAP (КАРТА ПАПОК)
Follow this exact nesting for every new feature:

```text
lib/
├── core/                # Shared logic (errors, network, theme)
    ├── database/                # Shared logic (errors, network, theme)
├── shared/              # Common UI widgets, constants
└── features/
    └── {feature_name}/  # Folder for each feature
        ├── data/        # Data Layer (Drift tables, Repositories)
        ├── domain/      # Business Entities (Freezed models)
        └── presentation/
            ├── bloc/    # BLoC files (Single-file style)
            ├── pages/   # Full screens
            └── widgets/ # Local UI components