import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  Future<void> loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counterValue') ?? 0;
    });
  }

  Future<void> saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counterValue', counter);
  }

  void increment() {
    setState(() => counter++);
    saveCounter();
  }

  void decrement() {
    if (counter > 0) {
      setState(() => counter--);
      saveCounter();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Counter Value:", style: TextStyle(fontSize: 22)),
            Text(
              "$counter",
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: decrement,
                  child: const Text("Decrease"),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: increment,
                  child: const Text("Increase"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
