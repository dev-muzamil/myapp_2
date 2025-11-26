📌 Project Overview

A simple Flutter project demonstrating basic state management and local data persistence using SharedPreferences.
The app contains two screens:

Counter Screen – Increase/decrease counter + auto-save using SharedPreferences

To-Do List Screen – Add tasks, display tasks, auto-save tasks locally

Project Structure

lib/
 ├── main.dart
 ├── screens/
 │    ├── counter_screen.dart
 │    └── todo_screen.dart
 ├── widgets/
 │    └── task_tile.dart


🎯 Features
🔢 1. Counter Screen

>Increase or decrease a counter using buttons

>Counter state managed using setState

>Counter value saved automatically using SharedPreferences

>Value restored even after app restart

📝 2. To-Do List Screen

>Add new tasks

>View tasks in a ListView

>Tasks stored locally using SharedPreferences

>Data persists across sessions

>Clean UI with a reusable TaskTile widget


🚀 How It Works

🔹 State Management

This project uses setState for simple UI state updates.

🔹 Local Storage

We store simple values using:

SharedPreferences prefs = await SharedPreferences.getInstance();

Counter is stored as an integer:

prefs.setInt('counter', counterValue);

To-Do list is stored as a List<String>:

prefs.setStringList('tasks', taskList);

📦 Required Dependencies

Your pubspec.yaml must include:

dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2

Run:

>flutter pub get

▶️ Running the App

Use the following command:

>flutter run

✨ What You Learn From This Project

✔ setState basics
✔ Multi-screen navigation
✔ Creating reusable widgets
✔ Using SharedPreferences for saving data
✔ Managing lists and integers locally
✔ Structuring a Flutter project cleanly
