import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../models/call_summary.dart';
import '../services/summary_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<CallSummary> summaries = [];
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadSummaries();
  }

  Future<void> _loadSummaries() async {
    final data = SummaryStorageService.getSummaries();
    setState(() {
      summaries = data;
    });
  }

  Future<void> _speak(String text) async {
    final prefs = await SharedPreferences.getInstance();
    final isEnabled = prefs.getBool('tts_enabled') ?? true;
    if (!isEnabled) return;

    await flutterTts.setLanguage("en-GB");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.45);
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Summaries')),
      body: RefreshIndicator(
        onRefresh: _loadSummaries,
        child: summaries.isEmpty
            ? const Center(child: Text("No summaries yet."))
            : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: summaries.length,
          itemBuilder: (context, index) {
            final summary = summaries[index];
            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(summary.caller),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Text(
                      summary.summary,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${summary.timestamp}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.volume_up, color: Colors.white),
                  onPressed: () => _speak(summary.summary),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
