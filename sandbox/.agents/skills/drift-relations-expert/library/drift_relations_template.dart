// [STRICT_TEMPLATE]: DRIFT_TABLE_RELATIONS
import 'package:drift/drift.dart';

// --- PARENT TABLE (ОСНОВНАЯ) ---
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

// --- CHILD TABLE (ЗАВИСИМАЯ) ---
class Products extends Table {
  // 1. Primary Key (Custom)
  @override
  Set<Column> get primaryKey => {id};
  IntColumn get id => integer()();

  // 2. Foreign Key (Связь с Categories)
  // ВАЖНО: .references(Categories, #id)
  IntColumn get categoryId => integer().nullable().references(
    Categories,
    #id,
    onDelete: KeyAction.cascade, // Удалить продукт, если удалена категория
    onUpdate: KeyAction.cascade,
  )();

  // 3. Various Types
  TextColumn get title => text().withLength(min: 3, max: 255)();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

// --- MANY-TO-MANY LINK TABLE (СВЯЗУЮЩАЯ) ---
class ProductTags extends Table {
  IntColumn get productId => integer().references(Products, #id)();
  IntColumn get tagId => integer().references(Tags, #id)();

  @override
  Set<Column> get primaryKey => {productId, tagId}; // Составной ключ
}
