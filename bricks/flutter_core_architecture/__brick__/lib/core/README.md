# Core Layer
Global infrastructure that is shared across the entire application.

- `database/`: Main AppDatabase, migrations, common converters
- `network/`: HttpClient, Interceptors, shared DTOs
- `router/`: App router configuration (e.g., GoRouter)
- `theme/`: Global theme and design system tokens
- `di/`: Root dependency injection and global service locators
- `error/`: Global Failures and Exceptions models
