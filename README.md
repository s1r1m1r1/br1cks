добавить рекурсивно в пакет
```zsh
cd bricks;
for d in */; do mason bundle "$d" -o "../bundles/${d%/}.
```


1. Добавление бандлов в проект через CLI
Перейдите в корень вашего целевого проекта (там, где лежит mason.yaml) и выполните:
zsh
# Цикл проходит по всем .bundle файлам в соседней папке и добавляет их
for f in ../bundles/*.bundle; do 
  mason add "$(basename "$f" .bundle)" --path "$f"
done
Используйте код с осторожностью.

Что делает эта команда:
$(basename "$f" .bundle) — вырезает имя файла (например, drift_db) для названия кирпича.
--path "$f" — указывает Mason, что источник кирпича — локальный файл бандла.


//--------------------------------------------------


1. Перегенерация бандлов в формат Dart
Выполните этот цикл в папке bricks, чтобы получить .dart файлы вместо бинарных .bundle. Это позволит скомпилировать их прямо в код вашего агента.
```zsh
for d in */; do 
  [ -f "$d/brick.yaml" ] && mason bundle "$d" -t dart -o "../bundles/${d%/}_bundle.dart"
done
```

2. Подключение к агенту (Dart проект)
Поместите сгенерированные файлы в папку lib/src/bundles/ вашего проекта. Теперь агент может импортировать их:
```dart
import 'package:your_package/src/bundles/agent_bloc_expert_bundle.dart';
import 'package:mason/mason.dart';
// В коде агента:
final brick = MasonGenerator.fromBundle(agentBlocExpertBundle);

```


3. Прямой вызов (Интеграция)
Чтобы агент мог «выполнить» кирпич, создайте простую функцию-обертку. Агент будет передавать в неё имя кирпича и переменные (vars):
```dart
Future<void> generateBrick({
  required String brickName, 
  required Map<String, dynamic> variables,
  String outputPath = '.',
}) async {
  // Выбираем нужный бандл (можно сделать через Map)
  final bundle = allBundles[brickName]; 
  
  final generator = await MasonGenerator.fromBundle(bundle);
  final target = DirectoryGeneratorTarget(Directory(outputPath));
  
  await generator.generate(target, vars: variables);
}
```
Используйте код с осторожностью.


Почему это лучше для Агента?
Автономность: Агенту не нужно проверять, установлен ли mason в системе.
Скорость: Генерация происходит внутри процесса Dart.
Безопасность: Вы точно контролируете, какие параметры (vars) агент передает в шаблон.
Нужна помощь с написанием маппинга (реестра) всех ваших 8 кирпичей для удобного вызова агентом?