import 'package:flutter/material.dart';
import 'summary_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CallSentinel'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', height: 120),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                icon: const Icon(Icons.play_circle_outline),
                label: const Text('Start Listening'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.greenAccent,
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // Placeholder
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('View Summary'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SummaryScreen()));
                },
              ),
              const SizedBox(height: 10),
              TextButton(
                child: const Text('Settings'),
                onPressed: () {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SettingsScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
