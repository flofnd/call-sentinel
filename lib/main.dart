import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/home_screen.dart';
import 'services/summary_storage_service.dart';
import 'services/hive_mock_injection.dart';
import 'services/permission_service.dart';
import 'package:flutter/services.dart';
import 'models/call_summary.dart';
import 'services/ai_summary_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Hive
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await SummaryStorageService.init();

  // Inject test data
  await injectMockSummaries();

  WidgetsFlutterBinding.ensureInitialized();
  await PermissionService.requestPhonePermissions();
  const platform = MethodChannel('com.callsentinel/call_info');

  platform.setMethodCallHandler((call) async {
    if (call.method == 'incoming_call') {
      final phoneNumber = call.arguments as String;

      // You could generate a fake transcript here, or use actual voice later
      final fakeTranscript = "Caller $phoneNumber mentioned an urgent offer about your bank account.";

      // Generate summary via GPT
      final summary = await AISummaryService.generateSummary(fakeTranscript);

      // Save to Hive
      final callSummary = CallSummary(
        caller: phoneNumber,
        summary: summary,
        timestamp: DateTime.now(),
      );

      await SummaryStorageService.addSummary(callSummary);
      print("✅ Saved summary for $phoneNumber");
    }
  });

  runApp(const CallSentinelApp());
}

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
