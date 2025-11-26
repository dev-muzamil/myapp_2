import 'package:flutter/material.dart';
import 'screens/counter_screen.dart';
import 'screens/todo_screen.dart';

void main() {
  runApp(const Week2App());
}

class Week2App extends StatelessWidget {
  const Week2App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Week 2 App',
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;

  final screens = [const CounterScreen(), const TodoScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (value) {
          setState(() => _index = value);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.exposure_plus_1),
            label: "Counter",
          ),
          NavigationDestination(icon: Icon(Icons.list_alt), label: "To-Do"),
        ],
      ),
    );
  }
}
