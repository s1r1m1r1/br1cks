---
name: drift-relations-expert
description: Drift SQLite relations (FK, Primary Keys, Cascades).
---

# 🔗 DRIFT RELATIONS RULES
Используй чистый Dart синтаксис для связей. НЕ используй `.drift` файлы.

## 1. FOREIGN KEYS (ВНЕШНИЕ КЛЮЧИ)
- **Синтаксис**: `integer().references(TableName, #columnName)();`
- **Actions**: Всегда указывай `onDelete: KeyAction.cascade` для дочерних сущностей.
- **Nullability**: Если связь обязательна, НЕ ставь `.nullable()`.

## 2. KEYS (КЛЮЧИ)
- **AutoIncrement**: Используй `integer().autoIncrement()();` для простых ID.
- **Composite Key**: Если нужно два ключа (многие-ко-многим), переопределяй `primaryKey`:
  `@override Set<Column> get primaryKey => {col1, col2};`

## 4. COMMAND LINE HINTS (STRICT)
Для создания таблицы используй и укажи корректную директорию:
`mason make drift_table --name={table_name} --output-dir=lib/features/{feature_name}/data/database --no-hooks`

Для генерации кода после изменений:
`dart run build_runner build -d`

## 3. JOIN QUERIES (ЗАПРОСЫ)
Для моделей 8B: если нужен JOIN, пиши его в DAO:
```dart
Future<List<ProductWithCategory>> getProducts() {
  final query = select(products).join([
    innerJoin(categories, categories.id.equalsExp(products.categoryId)),
  ]);
  // ... логика маппинга
}
