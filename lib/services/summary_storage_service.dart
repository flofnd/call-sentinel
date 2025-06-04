import 'package:hive/hive.dart';
import '../models/call_summary.dart';

class SummaryStorageService {
  static const String boxName = "call_summaries";

  static Future<void> init() async {
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(CallSummaryAdapter());
    }
    await Hive.openBox<CallSummary>(boxName);
  }

  static Future<void> addSummary(CallSummary summary) async {
    final box = Hive.box<CallSummary>(boxName);
    await box.add(summary);
  }

  static List<CallSummary> getSummaries() {
    final box = Hive.box<CallSummary>(boxName);
    return box.values.toList().reversed.toList();
  }

  static Future<void> clearSummaries() async {
    final box = Hive.box<CallSummary>(boxName);
    await box.clear();
  }
}
