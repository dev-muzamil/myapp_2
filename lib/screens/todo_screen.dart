import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/task_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController controller = TextEditingController();
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('todoList') ?? [];
    });
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('todoList', tasks);
  }

  void addTask() {
    final text = controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      tasks.add(text);
      controller.clear();
    });

    saveTasks();
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });

    saveTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter a task",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: addTask, child: const Text("Add")),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: tasks.isEmpty
                  ? const Center(child: Text("No tasks added yet"))
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) => TaskTile(
                        task: tasks[index],
                        onDelete: () => removeTask(index),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
