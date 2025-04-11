import 'package:dance_up/core/theme/theme.dart';
import 'package:dance_up/features/auth/screens/auth.dart';
import 'package:flutter/material.dart';

class DanceApp extends StatelessWidget {
  const DanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dance Up',
      theme: AppTheme.lightTheme,
      // home: const MeetDancersScreen(),
      home: const AuthScreen(),
      // home: const HomePage(title: 'Dance App'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to Dance Up!',
            ),
          ],
        ),
      ),
    );
  }
}
