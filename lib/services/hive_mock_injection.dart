import '../models/call_summary.dart';
import 'summary_storage_service.dart';

import 'ai_summary_service.dart';

Future<void> injectMockSummaries() async {
  final samples = [
    CallSummary(
      caller: "Unknown Caller +441234567890",
      summary: "Claimed to be from your bank offering a suspicious investment opportunity.",
      timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
    ),
    CallSummary(
      caller: "Spam Likely +33123456789",
      summary: "Automated voice claiming to offer car insurance renewal.",
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
    ),
    CallSummary(
      caller: "Unknown +4987654321",
      summary: "Caller asked about your recent internet usage and offered a speed upgrade.",
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
    ),
  ];

  // for (var summary in samples) {
  //   await SummaryStorageService.addSummary(summary);
  // }
  for (var raw in samples) {
    final summaryText = await AISummaryService.generateSummary(raw.summary);
    final callSummary = CallSummary(
      caller: raw.caller,
      summary: summaryText,
      timestamp: raw.timestamp,
    );
    await SummaryStorageService.addSummary(callSummary);
  }

  print("✅ Mock summaries injected.");
}
