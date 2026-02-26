---
name: drift-dao-expert
description: Advanced Drift usage with DAOs for feature isolation.
---

# 🛡 DRIFT DAO RULES
Use DAOs to separate database logic by features. 

## 1. STRUCTURE (СТРУКТУРА)
- **Table**: `lib/features/{feature}/data/database/tables.dart`
- **DAO**: `lib/features/{feature}/data/database/dao.dart`
- **Register**: Добавь DAO в основной класс `AppDatabase` в `core/`.

## 2. CODE RULES (ПРАВИЛА)
- **Boilerplate**: Всегда используй `part 'dao.g.dart';` и `DatabaseAccessor`.
- **Naming**: Называй методы просто: `getAll()`, `insertOne()`, `watchByStatus()`.
- **Companions**: Для вставки данных всегда используй `Companion` классы.

## 3. FLOW (ПОРЯДОК РАБОТЫ)
Если создаешь новую таблицу/DAO:
1. Создай файл `tables.dart`.
2. Создай файл `dao.dart` по шаблону `drift_dao_template.dart`.
3. Зарегистрируй DAO в `app_database.dart` в секции `daos: [...]`.

## 4. COMMAND LINE HINTS (STRICT)
Для генерации кода используй:
`mason make drift_dao --name={feature_name} --output-dir=lib/features/{feature_name}/data/database --no-hooks`

Для обновления файлов Freezed/Drift:
`dart run build_runner build -d`

## 5. INTEGRATION (СВЯЗКА)
- Внедряй (Inject) экземпляр DAO в **Repository**, а не всю базу данных. Это защищает архитектуру.