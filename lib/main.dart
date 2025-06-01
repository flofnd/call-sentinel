import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const CallSentinelApp());

class CallSentinelApp extends StatelessWidget {
  const CallSentinelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CallSentinel',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
