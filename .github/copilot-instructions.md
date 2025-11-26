# Flutter Learning App - Copilot Instructions

## Project Overview
A Flutter learning project featuring a tabbed application with two screens: **Counter** and **To-Do List**. Both screens persist data locally using `shared_preferences`, and the app uses Material Design 3.

## Architecture & Code Organization

### Directory Structure
- `lib/main.dart` - Entry point with `Week2App` (MaterialApp) and `HomePage` (tab navigator)
- `lib/screens/` - Two full-screen widgets: `CounterScreen` and `TodoScreen`
- `lib/widgets/` - Reusable components like `TaskTile` (card-based list item)

### Key Patterns

**Screen Architecture**: All screens extend `StatefulWidget` (not stateless) because they manage local state and lifecycle:
```dart
class CounterScreen extends StatefulWidget {
  @override
  void initState() { loadCounter(); }  // Load data on mount
}
```

**Persistence Pattern**: Both screens follow identical persistence flow:
1. `initState()` → call `loadXXX()` → `setState()` with retrieved data
2. Every mutation (add/increment/delete) → `setState()` → call `saveXXX()`

Use this pattern for any new persistent features.

**Naming Conventions**:
- Screens: `{Feature}Screen` (e.g., `CounterScreen`, `TodoScreen`)
- Widgets: descriptive nouns (e.g., `TaskTile`, not `TaskWidget`)
- Private fields: `_fieldName`
- Methods: camelCase with clear intent (e.g., `loadCounter`, `addTask`)

## Data Persistence (`shared_preferences`)

**Key operations**:
```dart
final prefs = await SharedPreferences.getInstance();
prefs.getInt('key') ?? defaultValue;      // Counter pattern
prefs.setInt('key', value);               // Save counter
prefs.getStringList('key') ?? [];         // Todo list pattern
prefs.setStringList('key', list);         // Save list
```

**Always use try-catch** when adding new persistence to handle potential errors. Currently not done in this codebase but recommended.

## UI/Widget Conventions

- **Navigation**: Bottom `NavigationBar` (Material 3) in `HomePage._HomePageState`
- **Material Design 3**: Enabled in `ThemeData` - use Material 3 components
- **Icons**: Use `Icons` from material package (e.g., `Icons.exposure_plus_1` for counter, `Icons.list_alt` for todo)
- **Spacing**: Consistent use of `SizedBox` for padding/gaps (e.g., `SizedBox(height: 20)`)
- **Reusable components**: Extract stateless widgets for repeated layouts (see `TaskTile` pattern)

## Development Commands

```bash
# Get dependencies
flutter pub get

# Run the app
flutter run

# Analyze code quality
flutter analyze

# Format code
dart format lib/

# Run tests (placeholder test exists)
flutter test

# Build APK (Android)
flutter build apk
```

## Common Tasks

**Add a new persistent property**:
1. Add getter in `initState()` using `SharedPreferences.getInstance().getXXX('key')`
2. Wrap getter in `setState()` to trigger UI rebuild
3. Add setter after mutations: `SharedPreferences.getInstance().setXXX('key', value)`

**Add a new screen**:
1. Create file in `lib/screens/{Feature}Screen.dart` extending `StatefulWidget`
2. Add corresponding `NavigationDestination` in `HomePage` destinations list
3. Add to `screens` list in `_HomePageState`

**Create a reusable component**:
Extend `StatelessWidget` and pass data as final fields (see `TaskTile` pattern). Use callbacks for actions (`VoidCallback` or custom function types).

## Dependencies
- `flutter` - core framework
- `shared_preferences: ^2.3.2` - local data storage
- `flutter_lints: ^4.0.0` - code quality (analysis_options.yaml configured)

## Known Patterns to Maintain
- Screens manage their own state (no separate service layer yet)
- UI and persistence logic coexist in screen widgets
- Tasks are stored as plain `List<String>` (no complex objects)
- Counter stored as single `int` value

## File Locations Reference
- App entry point: `lib/main.dart`
- Counter logic: `lib/screens/counter_screen.dart`
- Todo logic: `lib/screens/todo_screen.dart`
- Task UI component: `lib/widgets/task_tile.dart`
- Project config: `pubspec.yaml`
