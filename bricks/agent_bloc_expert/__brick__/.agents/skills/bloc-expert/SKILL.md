---
name: bloc-expert
description: Optimized for models. Single file BLoC + Freezed. Unified with bloc_9.
---

# 🚨 STRICT RULES
Ignoring these rules will lead to project failure.

## 1. STRUCTURE (UNIFIED WITH BLOC_9)
- 🧱 Use the `bloc_9` brick to generate new blocs.
- 📁 Standard directory: `lib/features/{feature_name}/presentation/bloc/`.
- 📄 Architecture: Split into `_bloc.dart`, `_event.dart`, `_state.dart`.

## 2. DEPRECATED SYNTAX PROHIBITION
- ❌ PROHIBITED: `mapEventToState`.
- ✅ ALLOWED: Only `on<Event>((event, emit) async { ... })` or `on<Event>(_onMethod)`.
- ❌ PROHIBITED: `abstract class Event`.
- ✅ ALLOWED: Only `sealed class {Name}Event with _${Name}Event`.

## 3. FILE COUPLING (FREEZED)
- If a file contains the `@freezed` annotation, you MUST add:
  `part '[filename].freezed.dart';`
- For the Bloc: `part '[filename]_bloc.freezed.dart';` (if freezed is used within the bloc itself) or simply imports for events/states.

## 4. PRE-RESPONSE CHECKLIST (SELF-VALIDATION)
Before outputting code, verify against this list:
1. Is `sealed` used for both events and states?
2. Is the `part` directive included for freezed?
3. Is `on<...>` used inside the Bloc constructor?

## 5. TRIGGER COMMANDS
- `gen-bloc [Name]`:
  1. Execute command: `mason make bloc_9 --name [name]`
  2. If the brick is unavailable, use the template from `/.agents/skills/library/bloc_template.dart`.
  3. After generation, run: `dart run build_runner build --delete-conflicting-outputs`

## 6. NO-GO ZONE (PROHIBITIONS)
- NO manual Equatable (use Freezed only).
- NO logic in the UI (only through Bloc).
- NO complex nested ternary operators in `emit`.
