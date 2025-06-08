import 'package:flutter/material.dart';
import 'summary_screen.dart';
import 'settings_screen.dart';
import '../services/ai_summary_service.dart';
import '../services/summary_storage_service.dart';
import '../models/call_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _simulateCall(BuildContext context) async {
    const fakeNumber = "+1234567890";
    const fakeTranscript = "Caller $fakeNumber claimed to be from your bank and requested sensitive information.";

    final summary = await AISummaryService.generateSummary(fakeTranscript);

    final callSummary = CallSummary(
      caller: fakeNumber,
      summary: summary,
      timestamp: DateTime.now(),
    );

    await SummaryStorageService.addSummary(callSummary);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("✅ Simulated call added to summaries")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CallSentinel'),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', height: 100),
                const SizedBox(height: 20),
                const Text(
                  "Call Sentinel AI",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton.icon(
                  icon: const Icon(Icons.mic_none),
                  label: const Text('Start Listening'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    minimumSize: const Size(double.infinity, 50),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {},
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  child: const Text('View Summaries'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SummaryScreen()),
                    );
                  },
                ),
                TextButton(
                  child: const Text('Settings'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const SettingsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 30),
                ElevatedButton.icon(
                  icon: const Icon(Icons.phone_forwarded),
                  label: const Text("Simulate Incoming Call"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () => _simulateCall(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
