import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'screens/home_screen.dart';
import 'services/summary_storage_service.dart';
import 'services/hive_mock_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup Hive
  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);
  await SummaryStorageService.init();

  // Inject test data
  await injectMockSummaries();

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
