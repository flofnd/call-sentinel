import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:share_plus/share_plus.dart';

import '../models/call_summary.dart';
import '../services/summary_storage_service.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  List<CallSummary> summaries = [];
  final FlutterTts flutterTts = FlutterTts();
  final ScrollController _scrollController = ScrollController();

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

  void _showFullSummary(CallSummary summary) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(summary.caller),
        content: Text(summary.summary),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  void _shareSummary(CallSummary summary) {
    final text = "Caller: \${summary.caller}\n\nSummary:\n\${summary.summary}";
    Share.share(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Call Summaries')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black87, Colors.black54],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _loadSummaries,
          child: summaries.isEmpty
              ? const Center(
            child: Text(
              "No summaries yet.",
              style: TextStyle(color: Colors.white70),
            ),
          )
              : Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            interactive: true,
            thickness: 6,
            radius: const Radius.circular(4),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: summaries.length,
              itemBuilder: (context, index) {
                final summary = summaries[index];
                return Dismissible(
                  key: Key(summary.timestamp.toIso8601String()),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    SummaryStorageService.deleteSummary(summary);
                    setState(() => summaries.removeAt(index));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Summary deleted')),
                    );
                  },
                  child: Card(
                    color: Colors.grey[900],
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const CircleAvatar(
                                backgroundColor: Colors.grey,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  summary.caller,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.volume_up, color: Colors.greenAccent),
                                onPressed: () => _speak(summary.summary),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share, color: Colors.white60),
                                onPressed: () {
                                  _shareSummary(summary);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () => _showFullSummary(summary),
                            child: Text(
                              summary.summary,
                              style: const TextStyle(color: Colors.white70),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            summary.timestamp.toString().substring(0, 19),
                            style: TextStyle(color: Colors.grey[500], fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
